

/// @func CoroutineTransform();
/// @desc For transforming AST nodes into directed graph.
function CoroutineTransform() constructor
{
  self.labels = {};
  self.tables = [];
  self.register = 0;
  
  
  // Dummy final node.
  static final = { 
    execute: function() {
      return execute; // Dummy.
    }
  };
    
  // Don't allow breaking outside the loop.
  static errorBreak = { 
    execute: function() 
    { 
      throw("BREAK used outside a loop."); 
      return execute; 
    }
  };
    
  // Don't allow breaking
  static errorContinue = { 
    execute: function() 
    { 
      throw("CONTINUE used outside a loop."); 
      return execute; 
    }
  };
  
  
  /// @func Dispatch(_root);
  /// @desc Transforms AST nodes into executable directed graph.
  /// @param {Struct} _root
  static Dispatch = function(_root)
  {
    self.tables = _root.tables;
    self.labels = _root.labels;
    self.register = 0;
    
    _root.graph = Generate(_root.nodes, final, errorBreak, errorContinue);
    _root.execute = _root.graph.execute;
    return _root;
  };
  
  
  /// @func Generate(_node, _next, _break, _continue);
  /// @desc Finds out generator based on node-type.
  /// @param {Struct} _node
  /// @param {Struct} _next
  /// @param {Struct} _break
  /// @param {Struct} _continue
  static Generate = function(_node, _next, _break, _continue)
  {
    return functors[$ _node.name](_node, _next, _break, _continue);
  };
  
  
  // LOOK-UP TABLE for GENERATORS.
  // Could use large switch-statement instead, but in GML it is just fance if-else -chain.
  // So with enough cases, having explicit lookup-table is faster in general case.
  static functors = coroutine_mapping([
    
    
    // Marks beginning of the coroutine execution.
    // Calls trigger for initializing.
    ["BEGIN"],
    function(_node, _next, _break, _continue)
    {
      return { 
        next: _next.execute,
        execute: function()
        {
          COROUTINE_CURRENT.onInit();
          COROUTINE_EXECUTE = next;
        }
      };
    },
    
    
    // Marks end of the coroutine execution.
    // Calls trigger for completion.
    ["FINISH"],
    function(_node, _next, _break, _continue)
    {
      return { 
        execute: function()
        {
          // feather ignore GM1049
          with(COROUTINE_CURRENT)
          {
            Execute(trigger.onComplete);
            Finish(undefined);
          }
          COROUTINE_EXECUTE = execute;
          COROUTINE_YIELD = true;
        }
      };
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
        _next = Generate(_nodes[i], _next, _break, _continue);
      }
      return _next;
    },
    
    
    // Statement, which may return control flow commands.
    // These are way executing regular GML code.
    ["STMT"],
    function(_node, _next, _break, _continue)
    {
      return { 
        next: _next.execute,
        call: _node.call, 
        onBreak: _break.execute,
        onContinue: _continue.execute,
        execute: function()
        {
          COROUTINE_EXECUTE = coroutine_execute(call) ?? next;
        }
      };
    },
    
    
    // Labels for goto -targets.
    // Doesn't produce new node, only marks position.
    ["LABEL"],
    function(_node, _next, _break, _continue)
    {
      labels[$ _node.label] = _next.execute;
      return _next;
    },
    
    
    // Yields execution, and allows others also to do execution.
    // This can also return value.
    ["YIELD"],
    function(_node, _next, _break, _continue)
    {
      return { 
        next: _next.execute,
        call: _node.call, 
        execute: function()
        {
          COROUTINE_RESULT = coroutine_execute(call);
          COROUTINE_EXECUTE = next;
          COROUTINE_YIELD = true;
        }
      };
    },
    
    
    // Pauses and yields coroutine execution.
    // This can also return value.
    ["PAUSE"],
    function(_node, _next, _break, _continue)
    {
      return { 
        next: _next.execute,
        call: _node.call,
        execute: function()
        {
          COROUTINE_LIST_PAUSED.InsertTail(link);
          COROUTINE_RESULT = coroutine_execute(call);
          coroutine_execute(COROUTINE_CURRENT.trigger.onPause);
          COROUTINE_EXECUTE = next;
          COROUTINE_YIELD = true;
        }
      };
    },
    
    
    // Pauses coroutine execution until given time is passed.
    // Allows different units of time to be used.
    ["DELAY"],
    function(_node, _next, _break, _continue)
    {
      // Cases for different delay-types.
      static rates = coroutine_mapping([
        ["MICROS"], function(_value) { return _value; }, 
        ["MILLIS"], function(_value) { return _value * 1_000.0; }, 
        ["FRAMES"], function(_value) { return _value * game_get_speed(gamespeed_microseconds); }, 
        ["SECONDS"], function(_value) { return _value * 1_000_000.0; }, 
      ]);
      
      // Split into two parts, first get initial value.
      var _init = {
        next: undefined,
        call: _node.call,
        rate: rates[$ _node.type],
        register,
        execute: function()
        {
          var _begin = get_timer();
          var _delay = coroutine_execute(call);
          COROUTINE_LOCAL[register] = _begin + rate(_delay);
          COROUTINE_EXECUTE = next;
        }
      };
      
      // Second part is yield-loop until the time is met.
      var _wait = {
        next: _next.execute,
        register,
        execute: function()
        {
          if (get_timer() < COROUTINE_LOCAL[register])
          {
            COROUTINE_EXECUTE = execute;
            COROUTINE_YIELD = true;
            return;
          }
          COROUTINE_EXECUTE = next;
        }
      };
      
      // Patch as now second part is known.
      _init.next = _wait.execute;
      return _init;
    },
    
    
    // Pauses execution until given condition is met.
    // Usual condition is boolean value, but it can be several other types.
    ["AWAIT"],
    function(_node, _next, _break, _continue)
    {
      static conditions = coroutine_mapping([
        ["COND"], function(_value) { return _value ?? true; }, 
        ["ASYNC"], function(_value) { return true; /* TODO */ }, 
        ["BROADCAST"], function(_value) { return true; /* TODO */ }, 
        ["COROUTINE"], function(_value) { return true; /* TODO */ }, 
      ]);
      
      return {
        next: _next.execute,
        call: _node.call,
        cond: conditions[$ _node.type],
        execute: function()
        {
          if (cond(coroutine_execute(call)))
          {
            COROUTINE_EXECUTE = next;
          }
          COROUTINE_EXECUTE = execute;
          COROUTINE_YIELD = true;
        }
      };
    },
    
    
    // Pauses execution until all child coroutines have finished.
    // 
    ["AWAIT_CHILDRENS"],
    function(_node, _next, _break, _continue)
    {
      return {
        next: _next.execute,
        execute: function()
        {
          if (COROUTINE_CURRENT.hasChilds() == false)
          {
            COROUTINE_EXECUTE = next;
          }
          COROUTINE_EXECUTE = execute;
          COROUTINE_YIELD = true;
        }
      };
    },
    
    
    // 
    // 
    ["ASYNC"],
    function(_node, _next, _break, _continue)
    {
      return {
        next: _next.execute,
        call: _node.call,
        type: _node.type,
        execute: function()
        {
          // TODO
          COROUTINE_EXECUTE = next;
        }
      };
    },
    
    
    // If-statement, regular branch statement.
    // 
    ["IF"],
    function(_node, _next, _break, _continue)
    {
      // Solve then and else -branches.
      var _then = Generate(_node.nodeThen, _next, _break, _continue);
      var _else = (_node.nodeElse != undefined)
        ? Generate(_node.nodeElse, _next, _break, _continue)
        : _next;
      
      return {
        next: _then.execute, 
        jump: _else.execute,
        cond: _node.cond,
        execute: function()
        {
          COROUTINE_EXECUTE = coroutine_execute(cond) ? next : jump;
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
        ? Generate(_node.def, _next, _break, _continue)
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
        var _body = Generate(_case.body, _next, _break, _continue);
        
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
          COROUTINE_EXECUTE = table[? coroutine_execute(item)] ?? def; 
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
          COROUTINE_EXECUTE = next;
        }
      };
      
      // Solve body and then patch, as loop target must be known beforehand.
      var _body = Generate(_node.body, _loop, _next, _loop);
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
          COROUTINE_EXECUTE = coroutine_execute(cond) ? next : jump;
        }
      };
      
      // Solve body and then patch, as loop target must be known beforehand.
      var _body = Generate(_node.body, _loop, _next, _loop);
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
          COROUTINE_LOCAL[register] = coroutine_execute(call);
          COROUTINE_EXECUTE = next;
        }
      };
      
      // Decrements counter and selects whether still do loop.
      var _loop = {
        next: undefined,
        jump: _next.execute,
        register: _register,
        execute: function()
        {
          COROUTINE_EXECUTE = (--COROUTINE_LOCAL[register] >= 0) ? next : jump;
        }
      };
      
      // Solve body and then patch, as loop target must be known beforehand.
      var _body = Generate(_node.body, _loop, _next, _loop);
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
          COROUTINE_EXECUTE = coroutine_execute(cond) ? jump : next;
        }
      };
      
      // Solve body and then patch, as loop target must be known beforehand.
      var _body = Generate(_node.body, _loop, _next, _loop);
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
          COROUTINE_EXECUTE = next;
        }
      }
      
      // Loop condition, whether break out.
      var _cond = {
        next: undefined,
        jump: undefined,
        cond: _node.cond,
        execute: function()
        {
          COROUTINE_EXECUTE = coroutine_execute(cond) ? next : jump;
        }
      };
      
      // Loop iteration.
      var _iter = {
        next: undefined,
        call: _node.iter,
        execute: function()
        {
          coroutine_execute(call);
          COROUTINE_EXECUTE = next;
        }
      };
      
      // Solve body and then patch, as loop target must be known beforehand.
      var _body = Generate(_node.body, _iter, _next, _iter);
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
          COROUTINE_LOCAL[register] = _iterator;
          COROUTINE_EXECUTE = next;
        }
      }
      
      // Does the loop iteration.
      var _loop = {
        next: undefined,
        jump: undefined,
        register: _register,
        execute: function()
        {
          var _iterator = COROUTINE_LOCAL[register];
          if (_iterator.index < _iterator.count)
          {
            _iterator.Next();
            COROUTINE_EXECUTE = next;
          }
          else
          {
            COROUTINE_LOCAL[register] = undefined;
            COROUTINE_EXECUTE = jump;
          }
        }
      };
      
      // Solve body and then patch, as loop target must be known beforehand.
      var _body = Generate(_node.body, _loop, _next, _loop);
      _init.next = _loop.execute;
      _loop.next = _body.execute;
      _loop.jump = _next.execute;
      
      // Finalize, free register.
      register--;
      return _init;
    },
  ]);
}















