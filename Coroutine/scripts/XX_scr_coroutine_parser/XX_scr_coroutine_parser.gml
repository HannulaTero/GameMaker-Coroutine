

/*
/// @func CoroutineParser();
/// @desc Generates linear instructions from given nodes (abstract syntax tree).
function CoroutineParser() constructor
{
  self.code = [];
  self.label = {};
  self.indexLoop = -1;
  self.indexRegister = -1;
  self.loops = ds_stack_create();
  
  
  /// @func Dispatch(_root);
  /// @desc 
  /// @param {Struct} _root
  static Dispatch = function(_root)
  {
    self.code = _root.code;
    self.label = _root.label;
    self.indexRegister = -1;
    Parse(_root.nodes);
    return new CoroutinePrototype(_root);
  };
  
  
  /// @func Free();
  /// @desc 
  /// @param {Struct.CoroutineParser}
  static Free = function()
  {
    self.code = undefined;
    self.label = undefined;
    self.indexRegister = undefined;
    ds_stack_destroy(loops);
    return self;
  };
  
  
  /// @func Parse(_node);
  /// @desc 
  /// @param {Array} _node
  static Parse = function(_node)
  {
    (parsers[$ _node.name] ?? parsers[$ "<UNKNOWN>"])(_node);
  };
  
  
  /// @func Instruction(_opcode);
  /// @desc 
  /// @param {String} _opcode
  static Instruction = function(_opcode)
  {
    // These "should" always exists, so this actually doesn't need error-check.
    return coroutine_instruction(_opcode) ?? Error($"Instruction not implemented: '{_opcode}'");
  };
  
  
  /// @func RegisterPush();
  /// @desc 
  /// @returns {Real}
  static RegisterPush = function()
  {
    return ++indexRegister;
  };
  
  
  /// @func RegisterPop();
  /// @desc 
  static RegisterPop = function()
  {
    --indexRegister;
  };
  
  
  /// @func ScopePush();
  /// @desc 
  static ScopePush = function()
  {
    //array_push(code, "SCP_PSH");
  };
  
  
  /// @func ScopePop();
  /// @desc 
  static ScopePop = function()
  {
    //array_push(code, "SCP_POP"); 
  };
  
  
  /// @func LoopPush();
  /// @desc 
  static LoopPush = function()
  {
    array_push(code, Instruction("LOOP_PUSH"), ++indexLoop, -1, -1);
    ds_stack_push(loops, array_length(code));
  };
  
  
  /// @func LoopCond(_cond);
  /// @desc 
  static LoopCond = function(_cond)
  {
    array_push(code, Instruction("LOOP_COND"), indexLoop, _cond);
  }
  
  
  /// @func LoopCondReg(_register);
  /// @desc 
  static LoopCondReg = function(_register)
  {
    array_push(code, Instruction("LOOP_COND_REG"), indexLoop, _register);
  }
  
  
  /// @func LoopCondForeachNext(_register);
  /// @desc 
  static LoopCondForeachNext = function(_register)
  {
    array_push(code, Instruction("FOREACH_NEXT"), indexLoop, _register);
  }
  
  
  /// @func LoopPop();
  /// @desc 
  static LoopPop = function()
  {
    var _begin = ds_stack_pop(loops);
    array_push(code, Instruction("JUMP"), _begin);
    var _exit = array_length(code);
    code[_begin - 2] = _begin; 
    code[_begin - 1] = _exit;
    --indexLoop;
  };
  
  
  /// @func EmitCode();
  /// @desc 
  static EmitCode = function()
  {
    var _index = array_length(code);
    for(var i = argument_count-1; i >= 1; i--)
    {
      code[_index + i] = argument[i];
    }
    code[_index] = Instruction(argument[0]);
  };
  
  
  /// @func EmitCall(_callback);
  /// @desc 
  /// @param {Function} _callback 
  static EmitCall = function(_callback)
  {
    array_push(code, Instruction("CALL"), _callback); 
  };
  
  
  /// @func EmitYield(_callback);
  /// @desc 
  /// @param {Function} _callback 
  static EmitYield = function(_callback)
  {
    array_push(code, Instruction("YIELD"), _callback); 
  };
  
  
  /// @func EmitJump(_loopBegin);
  /// @desc 
  static EmitJump = function(_loopBegin=-1)
  {
    array_push(code, Instruction("JUMP"), _loopBegin);
    return array_length(code) - 1;
  };
  
  
  /// @func EmitJumpCondCall(_callback);
  /// @desc 
  /// @param {Function} _callback 
  static EmitJumpCondCall = function(_callback)
  {
    array_push(code, Instruction("JUMP_COND_CALL"), _callback, -1);
    return array_length(code) - 1;
  };
  
  
  /// @func PatchJump(_jump);
  /// @desc 
  /// @param {Real} _jump 
  static PatchJump = function(_jump)
  {
    code[_jump] = array_length(code);
  };
  
  
  /// @func PatchJumps(_jumps);
  /// @desc 
  /// @param {Array<Real>} _jumps
  static PatchJumps = function(_jumps)
  {
    var _position = array_length(code);
    var _count = array_length(_jumps);
    for(var i = 0; i < _count; i++)
    {
      code[_jumps[i]] = _position;
    }
  };
  
  
  /// @func JumpTarget();
  /// @desc 
  static JumpTarget = function()
  {
    return array_length(code);
  };
  
  
  /// @func Error(_message);
  /// @desc 
  /// @param {String} _message
  static Error = function(_message)
  {
    throw(_message);
    return false;
  };
  
  
  // Lookup-table for parsing different node-types.
  // Of course a switch-statement could be used instead.
  static parsers = coroutine_mapping([ 
  
    // General error message.
    // At the time of writing, this is unused. But might be used later.
    ["<ERROR>"], 
    function(_node)
    {
      Error($"Error with node-type '{_node}'");
    },
    
    
    // All cases should be covered, and this shouldn't appear.
    // Though if new cases are added and it is forgotten to add here, then this should fire up.
    ["<UNKNOWN>"], 
    function(_node)
    {
      Error($"Unknown node-type '{_node}'");
    },
    
    
    // This is begin marker. 
    ["BEGIN"],
    function(_node)
    {
      EmitCode("BEGIN");
    },
    
    
    // This is EOF marker for the nodes.
    ["FINISH"],
    function(_node)
    {
      EmitCode("FINISH");
    },
    
    
    // THEN holds list of statements.
    // This could also be used to push and pop out variable scopes.
    ["THEN"],
    function(_node)
    {
      ScopePush();
      var _nodes = _node.nodes;
      var _count = array_length(_nodes);
      for(var i = 0; i < _count; i++)
      {
        Parse(_nodes[i]);
      }
      ScopePop();
    },
    
    
    // Way to split execution to several functions, and therefore possible positions
    // for coroutine to wait for the next frame, so it won't exceed frame-budget.
    // This is also requires syntax-wise with macros. 
    ["PASS"],
    function(_node)
    {
      EmitCall(_node.call);
    },
    
  
    // if-elif-else statement.
    // This can have a long chain of elif's.
    // For macro-syntax it was easier to make it as a chain rather than nesting structure,
    // as otherwise it would have required equal amount of closing END's or other way managing it.
    // But making cleaner in macro makes parsing node bit harder.
    ["IF"], 
    function(_node)
    {
      // Handle then-branch.
      var _jumpExit = EmitJumpCondCall(_node.cond);
      Parse(_node.nodeThen);
      
      // Handle then-branch
      if (_node.nodeElse != undefined)
      {
        var _jumpElse = EmitJump();
        PatchJump(_jumpExit);
        _jumpExit = _jumpElse;
        Parse(_node.nodeElse);
      }
      
      // Exiting the statement.
      PatchJump(_jumpExit);
    },
  
  
    // for -statement. Undefined marks whether optional parts are used.
    // These are 
    ["FOR"], 
    function(_node)
    {            
      EmitCall(_node.init);
      LoopPush();
      
      if (_node.cond != undefined)
        LoopCond(_node.cond);
      
      Parse(_node.body);
      
      if (_node.iter != undefined)
        EmitCall(_node.iter);
      
      LoopPop();
    },
  
  
    // while -statement.
    ["WHILE"], 
    function(_node)
    {
      LoopPush();
      LoopCond(_node.cond);
      Parse(_node.body);
      LoopPop();
    },
    
    
    // 
    // 
    ["REPEAT"], 
    function(_node)
    {
      // Get iteration count, loop starts after it.
      var _regCounter = RegisterPush();
      EmitCode("REG_CALL", _regCounter, _node.call);
      LoopPush();
      LoopCondReg(_regCounter);
      
      // Repeat body.
      Parse(_node.body);
      EmitCode("REG_DECR", _regCounter);
      
      // Finalize.
      LoopPop();
      RegisterPop();
    },
    
    
    // Foreach construct is used to iterate over iterables. 
    // The macro returns callback to determine variable-names, which are for storing iterations key and value.
    // It is a bit of an hack, but it is sought only once here during the parsing.
    ["FOREACH"],
    function(_node)
    {      
      // Initialize the foreach.
      var _register = RegisterPush(); 
      EmitCode("FOREACH_INIT", _register, _node.item, _node.key, _node.val);
      
      // Condition.
      LoopPush();
      LoopCondForeachNext(_register);
      Parse(_node.body);
      
      // Exit the loop.
      LoopPop();
      RegisterPop();
    },
  
  
    // 
    // 
    ["PAUSE"],
    function(_node)
    {
      EmitCode("PAUSE", _node.call);
    },
    
    
    // 
    // 
    ["YIELD"],
    function(_node)
    {
      EmitYield(_node.call);
    },
    
  
    // 
    // 
    ["DELAY"], 
    function(_node)
    {
      var _regTargetTime = RegisterPush();
      EmitCode("DELAY_INIT", _regTargetTime, _node.call, _node.type);
      EmitCode("DELAY_WAIT", _regTargetTime);
      RegisterPop();
    },
    
    
    // 
    // 
    ["ASYNC"], 
    function(_node)
    {
      EmitCode("ASYNC", _node.type);
      Parse(_node.body);
    },
    
    
    // 
    // 
    ["AWAIT"], 
    function(_node)
    {
      EmitCode("AWAIT", _node.type, _node.call);
    },
    
    
    // 
    // 
    ["TIMEOUT"], 
    function(_node)
    {
      EmitCode("TIMEOUT", _node.type, _node.call);
    },
  
  
    // 
    // 
    ["LABEL"],
    function(_node)
    {
      label[$ _node.label] = JumpTarget();
    },
  ]);
}









