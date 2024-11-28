

/// @func CoroutineCompile();
/// @desc For transforming AST nodes into directed graph.
function CoroutineCompile() constructor
{
  labels = {};
  tables = [];
  final = undefined;
  register = 0;
  
  
  // Dummy final node.
  static finalNode = { 
    next: function() { },
    execute: function() { /* Dummy. */ }
  };
    
  // Don't allow breaking outside the loop.
  static errorBreak = { 
    next: function() { },
    execute: function() 
    { 
      throw("BREAK used outside a loop.");
    }
  };
    
  // Don't allow breaking
  static errorContinue = { 
    next: function() { },
    execute: function() 
    { 
      throw("CONTINUE used outside a loop.");
    }
  };
  
  
  /// @func Dispatch(_root);
  /// @desc Transforms AST nodes into executable directed graph.
  /// @param {Struct} _root
  static Dispatch = function(_root)
  {
    tables = _root.tables;
    labels = _root.labels;
    code = _root.code;
    final = undefined;
    register = 0;
    
    _root.graph = Compile(_root.nodes, finalNode, errorBreak, errorContinue);
    _root.execute = _root.graph.execute;
    _root.final = final;
    return _root;
  };
  
  
  /// @func Compile(_node, _next, _break, _continue);
  /// @desc Finds out generator based on node-type.
  /// @param {Struct} _node
  /// @param {Struct} _next
  /// @param {Struct} _break
  /// @param {Struct} _continue
  static Compile = function(_node, _next, _break, _continue)
  {
    // Assumes nodes are valid, and there is always functor for given node-name.
    return functors[$ _node.name](_node, _next, _break, _continue);
  };
  
  
  // LOOK-UP TABLE for GENERATORS.
  /*
    Could use large switch-statement instead, but in GML it is just fancy if-else -chain.
    So with enough cases, having explicit lookup-table is faster in general case.
  
    These generator functions should be struct.
      Struct should have atleast "execute" and "next" -members.
      "execute" and "next should both be functions, which are called during execution.
      Returning struct also works as context, which handle/direct the functions execution.
    
    Executive functions assume, that manager calls, and global state is proper.
      Functions change global state to lead execution to next state.
    
  */
  static functors = coroutine_mapping([
    
    
    // Marks end of the coroutine execution.
    // Calls trigger for completion.
    ["FINISH"],
    function(_node, _next, _break, _continue)
    {
      array_push(code, method(undefined, function()
      {
        COROUTINE_CURRENT_TASK.onComplete();
        COROUTINE_CURRENT_TASK.Destroy();
        COROUTINE_INDEX--;
        return true;
      }));
    },
    
    
    // Holds block of statements.
    // When generating directed graph, block dissolves.
    ["BLOCK"],
    function(_block, _next, _break, _continue)
    {
      var _nodes = _block.nodes;
      var _count = array_length(_nodes);
      for(var i = _count-1; i >= 0; i--)
      {
        _next = Compile(_nodes[i], _next, _break, _continue);
      }
      return _next;
    },
    
    
    // Statement, which may return control flow commands.
    // These are way executing regular GML code.
    ["STMT"],
    function(_node, _next, _break, _continue)
    {
      array_push(code, method(undefined, function()
      {
        COROUTINE_INDEX = COROUTINE_CODE[COROUTINE_INDEX++]() ?? COROUTINE_INDEX;
        return false;
      }));
      
      array_push(code, _node.call);
    },
    
    
    // Labels for goto -targets.
    // Doesn't produce new node, only marks position.
    ["LABEL"],
    function(_node, _next, _break, _continue)
    {
      labels[$ _node.label] = array_length(code);
    },
    
    
    // Yields execution, and allows others also to do execution.
    // This can also return value.
    ["YIELD"],
    function(_node, _next, _break, _continue)
    {
      array_push(code, method(undefined, function()
      {
        COROUTINE_RESULT = COROUTINE_CODE[COROUTINE_INDEX++]();
        return true;
      }));
      
      array_push(code, _node.call);
    },
    
    
    // Pauses and yields coroutine execution.
    // This can also return value.
    ["PAUSE"],
    function(_node, _next, _break, _continue)
    {
      array_push(code, method(undefined, function()
      {
        COROUTINE_RESULT = COROUTINE_CODE[COROUTINE_INDEX++]();
        COROUTINE_CURRENT_TASK.onPause();
        return true;
      }));
      
      array_push(code, _node.call);
    },
    
    
    // Pauses coroutine execution until given time is passed.
    // Allows different units of time to be used.
    ["DELAY"],
    function(_node, _next, _break, _continue)
    {
      // Cases for different delay-types.
      static rates = coroutine_mapping([
        ["MICROS"], function() { return 1_000_000.0; }, 
        ["MILLIS"], function() { return 1_000.0; }, 
        ["FRAMES"], function() { return 1.0; }, 
        ["SECONDS"], function() { return 1.0; }, 
      ]);
      
      static units = coroutine_mapping([
        ["MICROS"], function() { return time_source_units_seconds; }, 
        ["MILLIS"], function() { return time_source_units_seconds; }, 
        ["FRAMES"], function() { return time_source_units_frames; }, 
        ["SECONDS"], function() { return time_source_units_seconds; }, 
      ]);
      
      array_push(code, method(undefined, function()
      {
        var _unit = COROUTINE_CODE[COROUTINE_INDEX++];
        var _rate = COROUTINE_CODE[COROUTINE_INDEX++];
        var _delay = COROUTINE_CODE[COROUTINE_INDEX++]() / _rate;
        
        with(COROUTINE_CURRENT_TASK)
        {
          // Delete from active and yield. 
          ds_map_delete(COROUTINE_POOL_ACTIVE, identifier);
          COROUTINE_POOL_DELAYED[? identifier] = self;
          
          // Return back to active after delay.
          time_source_reconfigure(delaySource, _delay, _unit, delayResume);
          time_source_start(delaySource);
        }
        
        return true;
      }));
      
      array_push(code, units[$ _node.type]());
      array_push(code, rates[$ _node.type]());
      array_push(code, _node.call);
    },
    
    
    // Pauses execution until given condition is met.
    ["AWAIT_COND"],
    function(_node, _next, _break, _continue)
    {
      array_push(code, method(undefined, function()
      {
        if (COROUTINE_CODE[COROUTINE_INDEX]())
        {
          COROUTINE_INDEX++;
          return false;
        }
        COROUTINE_INDEX--; // Back to condition.
        return true;
      }));
      
      array_push(code, _node.call);
    },
    
    
    ["AWAIT_ASYNC", "AWAIT_COROUTINE"],
    function(_node, _next, _break, _continue)
    {
      // Get the item, which is awaited.
      array_push(code, method(undefined, function()
      {
        COROUTINE_TEMPORAL = COROUTINE_CODE[COROUTINE_INDEX++]();
        return false;
      }));
      
      array_push(code, _node.call);
      
      // Await until item is finished.
      array_push(code, method(undefined, function()
      {
        if (COROUTINE_TEMPORAL.isFinished())
        {
          return false;
        }
        COROUTINE_INDEX--; // Back to condition.
        return true;
      }));
      
      array_push(code, register);
    },
    
    
    ["AWAIT_BROADCAST"],
    function(_node, _next, _break, _continue)
    {
      array_push(code, method(undefined, function()
      {
        var _broadcast = COROUTINE_CODE[COROUTINE_INDEX++]();
        COROUTINE_CURRENT_TASK.onPause();
        return true;
      }));
      
      array_push(code, _node.call);
    },
    
    
    // Pauses execution until all child coroutines have finished.
    // 
    ["AWAIT_SUBTASKS"],
    function(_node, _next, _break, _continue)
    {
      // Await until item is finished.
      array_push(code, method(undefined, function()
      {
        if (ds_map_size(COROUTINE_CURRENT_TASK.childs) <= 0)
        {
          return false;
        }
        COROUTINE_INDEX--; // Back to condition.
        return true;
      }));
    },
    
    
    // 
    // 
    ["ASYNC"],
    function(_node, _next, _break, _continue)
    {
      // TODO.
    },
    
    
    // If-statement, regular branch statement.
    // 
    ["IF"],
    function(_node, _next, _break, _continue)
    {
      // Condition.
      array_push(code, method(undefined, function()
      {
        if (COROUTINE_CODE[COROUTINE_INDEX]())
        {
          COROUTINE_INDEX += 2;
        }
        else
        {
          COROUTINE_INDEX = COROUTINE_CODE[COROUTINE_INDEX + 1];
        }
        return false;
      }));
      
      array_push(code, _node.call);
      array_push(code, -1); // exit-jump.
      var _jumpExit = array_length(code) - 1;
      
      Compile(_node.nodeThen, _next, _break, _continue);
      
      if (_node.nodeElse != undefined)
      {
        array_push(code, method(undefined, function()
        {
          COROUTINE_INDEX = COROUTINE_CODE[COROUTINE_INDEX];
        }));
        code[_jumpExit] = array_length(code);
        _jumpExit = array_length(code) - 1;
        Compile(_node.nodeElse, _next, _break, _continue);
      }
      
      code[_jumpExit] = array_length(code);
      
      
      
      // Solve then and else -branches.
      var _then = Compile(_node.nodeThen, _next, _break, _continue);
      var _else = (_node.nodeElse != undefined)
        ? Compile(_node.nodeElse, _next, _break, _continue)
        : _next;
      
      return {
        next: _then.execute, 
        jump: _else.execute,
        cond: _node.cond,
        execute: function()
        {
          COROUTINE_CURRENT_EXECUTE = coroutine_execute(cond) ? next : jump;
        }
      };
    },
    
    
    // Switch-statement, jump-table.
    // 
    ["SWITCH"],
    function(_node, _next, _break, _continue)
    {
      // Check whether there is default case.
      var _def = (_node.def != undefined)
        ? Compile(_node.def, _next, _break, _continue)
        : undefined;
        
      // Solve all cases into jump-table.
      var _table = ds_map_create();
      var _cases = _node.cases;
      var _count = array_length(_cases);
      for(var i = 0; i < _count; i++)
      {
        // Fetch case information.
        var _case = _cases[i];
        var _cond = _case.cond(); // Compile-time, no dynamic cases.
        var _body = Compile(_case.body, _next, _break, _continue);
        
        // Check whether multiple case-conditions.
        if (is_array(_cond))
        {
          var _condArray = _cond;
          var _condCount = array_length(_cond);
          for(var j = 0; j < _condCount; j++)
          {
            _cond = _condArray[j];
            if (ds_map_exists(_table, _cond))
            {
              throw($"SWITCH duplicate case '{_cond}'");
            }
            _table[? _cond] = _body.execute;
          }
        }
        
        // Only single case-condition.
        else
        {
          if (ds_map_exists(_table, _cond))
          {
            throw($"SWITCH duplicate case '{_cond}'");
          }
          _table[? _cond] = _body.execute;
        }
      }
      
      // Push dsmap reference for easier cleaning when prototype is destroyed.
      array_push(tables, _table);
      
      // Create executor.
      return {
        next: _next.execute, 
        item: _node.item,
        table: _table,
        def: (_def != undefined) ? _def.execute : _next.execute,
        execute: function() 
        { 
          COROUTINE_CURRENT_EXECUTE = table[? coroutine_execute(item)] ?? def; 
        }
      };
    },
    
    
    // Simple forever loop, always will repeat body.
    // Statement must either break or jump out the loop.
    ["LOOP"],
    function(_node, _next, _break, _continue)
    {
      var _loop = {
        next: undefined,
        execute: function() 
        { 
          COROUTINE_CURRENT_EXECUTE = next;
        }
      };
      
      // Solve body and then patch, as loop target must be known beforehand.
      var _body = Compile(_node.body, _loop, _next, _loop);
      _loop.next = _body.execute;
      return _loop;
    },
    
    
    // Basic conditional loop.
    // 
    ["WHILE"],
    function(_node, _next, _break, _continue)
    {
      var _loop = {
        next: undefined,
        jump: _next.execute,
        cond: _node.cond,
        execute: function()
        {
          COROUTINE_CURRENT_EXECUTE = coroutine_execute(cond) ? next : jump;
        }
      };
      
      // Solve body and then patch, as loop target must be known beforehand.
      var _body = Compile(_node.body, _loop, _next, _loop);
      _loop.next = _body.execute;
      return _loop;
    },
    
    
    // Repeat statement, which works similarly to GML.
    // 
    ["REPEAT"],
    function(_node, _next, _break, _continue)
    {
      // Reserve local for storing iterator.
      var _register = register++;
      
      // Loop is in two parts, first initalize repeat count.
      var _init = {
        next: undefined,
        call: _node.call,
        register: _register,
        execute: function()
        {
          COROUTINE_CURRENT_LOCAL[register] = coroutine_execute(call);
          COROUTINE_CURRENT_EXECUTE = next;
        }
      };
      
      // Decrements counter and selects whether still do loop.
      var _loop = {
        next: undefined,
        jump: _next.execute,
        register: _register,
        execute: function()
        {
          COROUTINE_CURRENT_EXECUTE = (--COROUTINE_CURRENT_LOCAL[register] >= 0) ? next : jump;
        }
      };
      
      // Solve body and then patch, as loop target must be known beforehand.
      var _body = Compile(_node.body, _loop, _next, _loop);
      _init.next = _loop.execute;
      _loop.next = _body.execute;

      // Finalize, free the register.
      register--;
      return _init;
    },
    
    
    // Do-until loop statement.
    // Almost same as While-loop, but the body is executed first and condition is reversed.
    ["DO"],
    function(_node, _next, _break, _continue)
    {
      var _loop = {
        next: undefined,
        jump: _next.execute,
        cond: _node.cond,
        execute: function()
        {
          COROUTINE_CURRENT_EXECUTE = coroutine_execute(cond) ? jump : next;
        }
      };
      
      // Solve body and then patch, as loop target must be known beforehand.
      var _body = Compile(_node.body, _loop, _next, _loop);
      _loop.next = _body.execute;
      return _body;
    },
    
    
    // For-statement.
    // 
    ["FOR"],
    function(_node, _next, _break, _continue)
    {
      // Initialize variables.
      var _init = {
        next: undefined,
        call: _node.init,
        execute: function()
        {
          coroutine_execute(call);
          COROUTINE_CURRENT_EXECUTE = next;
        }
      }
      
      // Loop condition, whether break out.
      var _cond = {
        next: undefined,
        jump: undefined,
        cond: _node.cond,
        execute: function()
        {
          COROUTINE_CURRENT_EXECUTE = coroutine_execute(cond) ? next : jump;
        }
      };
      
      // Loop iteration.
      var _iter = {
        next: undefined,
        call: _node.iter,
        execute: function()
        {
          coroutine_execute(call);
          COROUTINE_CURRENT_EXECUTE = next;
        }
      };
      
      // Solve body and then patch, as loop target must be known beforehand.
      var _body = Compile(_node.body, _iter, _next, _iter);
      _init.next = _cond.execute;
      _cond.next = _body.execute;
      _cond.jump = _next.execute;
      _iter.next = _cond.execute;
      
      return _init;
    },
    
    
    // Foreach statement for iterating different iterable items.
    // This uses own iterator-struct to keep up the state.
    ["FOREACH"],
    function(_node, _next, _break, _continue)
    {
      // Reserve local for storing iterator.
      var _register = register++;
      
      // Initializes iterator. 
      var _init = {
        next: undefined,
        call: _node.item,
        val: _node.val,
        key: _node.key,
        register: _register,
        execute: function()
        {
          var _item = coroutine_execute(call);
          var _iterator = new CoroutineIterator(_item, key, val);
          COROUTINE_CURRENT_LOCAL[register] = _iterator;
          COROUTINE_CURRENT_EXECUTE = next;
        }
      }
      
      // Does the loop iteration.
      var _loop = {
        next: undefined,
        jump: undefined,
        register: _register,
        execute: function()
        {
          var _iterator = COROUTINE_CURRENT_LOCAL[register];
          if (_iterator.index < _iterator.count)
          {
            _iterator.Next();
            COROUTINE_CURRENT_EXECUTE = next;
          }
          else
          {
            COROUTINE_CURRENT_LOCAL[register] = undefined;
            COROUTINE_CURRENT_EXECUTE = jump;
          }
        }
      };
      
      // Solve body and then patch, as loop target must be known beforehand.
      var _body = Compile(_node.body, _loop, _next, _loop);
      _init.next = _loop.execute;
      _loop.next = _body.execute;
      _loop.jump = _next.execute;
      
      // Finalize, free register.
      register--;
      return _init;
    },
  ]);
}















