/*
/// @func coroutine_instruction(_opcode);
/// @desc Returns executable function from given instruction name.
/// @param {String} _opcode
/// @returns {Function}
function coroutine_instruction(_opcode)
{
  //
  //Lookup-table for different instructions.
  //-> Of course a switch-statement could have been used instead.
  //
  //Execution scope is assumed to be the the coroutine. 
  //Returning "true" means coroutine will continue executing next instruction.
  //
  
  static instructions = coroutine_mapping([ 
    // feather ignore GM1049
    // feather ignore GM1041
    
  
    ["BEGIN"],
    function()
    {
      Execute(trigger.onInit);
      return false;
    },
    
  
    ["FINISH"],
    function()
    {
      ds_list_delete(__COROUTINE_INSTANCES, __COROUTINE_CURRENT--);
      if (parent != undefined)
      {
        struct_remove(parent.childs, identifier);
      }
      
      finished = true;
      result = undefined;
      
      Execute(trigger.onComplete);
      
      return false;
    },
    
    
    // Call just calls the callback function.
    // THere is nothing else to it.
    ["CALL"],
    function()
    {
      var _method = code[index++];
      with(scope) _method();
      return true;
    },
  
  
    ["LOOP_PUSH"],
    function()
    {
      var _indexLoop = code[index++];
      pointContinue[_indexLoop] = code[index++];
      pointBreak[_indexLoop] = code[index++];
      return true;
    },
  
  
    ["LOOP_COND"],
    function()
    {
      var _condition;
      var _indexLoop = code[index++];
      var _method = code[index++];
      with(scope) _condition = _method();
      if ((_condition ?? 0.0) <= 0.0)
      {
        index = pointBreak[_indexLoop];
      }
      return true;
    },
  
  
    ["LOOP_COND_REG"],
    function()
    {
      var _condition;
      var _indexLoop = code[index++];
      var _register = code[index++];
      if (local[_register] <= 0.0)
      {
        index = pointBreak[_indexLoop];
      }
    },  
  
  
    // Jump to any instruction in the code.
    // This is direct jump.
    ["JUMP"],
    function()
    {
      index = code[index];
      return true;
    },
  
  
    // Conditional jump based on callback.
    // Changes position if result is false, as if jumping into else-branch.
    // If true, then continues execution as normally it would.
    ["JUMP_COND_CALL"],
    function()
    {
      var _condition;
      var _method = code[index++];
      var _offset = code[index++];
      with(scope) _condition = _method();
      if ((_condition ?? 0.0) <= 0.0)
      {
        index = _offset;
      }
      return true;
    },
  
  
    // Conditional jump based on register.
    // Similar to conditional jump based on callback, but the value is taken from register.
    ["JUMP_COND_REG"],
    function()
    {
      var _condition;
      var _register = code[index++];
      var _offset = code[index++];
      if (local[_register] <= 0.0)
      {
        index = _offset;
      }
      return true;
    },
  
    
    ["FOREACH_INIT"],
    function()
    {
      // Preparations.
      var _register = code[index++];
      var _callItem = code[index++];
      var _nameValue = code[index++];
      var _nameKey = code[index++];
      
      // Define foreach-iterator.
      var _item = undefined;
      with(scope) _item = _callItem();
      var _iterator = new CoroutineIterator(); 
      _iterator.Initialize(_item, _nameValue, _nameKey);
      local[_register] = _iterator;
      return true;
    },
  
  
    ["FOREACH_NEXT"],
    function()
    {
      var _indexLoop = code[index++];
      var _register = code[index++];
      var _iterator = local[_register];
      if (_iterator.index < _iterator.count)
      {
        _iterator.Next(scope);
      }
      else
      {
        index = pointBreak[_indexLoop];
        _iterator.Free();
      }
      return true;
    },
  
  
    ["PAUSE"],
    function()
    {
      var _result = undefined;
      var _method = code[index++];
      with(scope) _result = _method();
      result = _result;
      paused = true;
      
      Execute(trigger.onPause);
      
      return true;
    },
  
  
    ["YIELD"],
    function()
    {
      var _result = undefined;
      var _method = code[index++];
      with(scope) _result = _method();
      result = _result;
      
      // Manager handles yield-trigger!
      return false;
    },
    
    
    ["DELAY_INIT"],
    function()
    {
      var _regTargetTime = code[index++];
      var _nodeCall = code[index++];
      var _nodeType = code[index++];
      
      // Get delay amount.
      var _delay = 0;
      with(scope) _delay = _nodeCall();
      
      // Transform to common time.
      switch(_nodeType)
      {
        case "MICROS": _delay *= 1.0; break;
        case "MILLIS": _delay *= 1_000.0; break;
        case "FRAMES": _delay *= game_get_speed(gamespeed_microseconds); break;
        case "SECONDS": _delay *= 1_000_000.0; break;
      }
      
      local[_regTargetTime] = get_timer() + _delay;
    },
    
    
    ["DELAY_WAIT"],
    function()
    {
      var _regTargetTime = code[index++];
      var _targetTime = local[_regTargetTime];
      var _currentTime = get_timer();
      if (_currentTime < _targetTime)
      {
        index -= 2; // Jump back.
        return false;
      }
      return true;
    },
  
  
    ["ASYNC"],
    function()
    {
      return true;
    },
  
  
    ["AWAIT"],
    function()
    {
      var _type = code[index++];
      var _call = code[index++];
      var _result = true;
      switch(_type)
      {
        case "COND": with(scope) _result = _call();
        case "ASYNC": with(scope) _result = _call();     // TODO.
        case "BROADCAST": with(scope) _result = _call(); // TODO.
        case "COROUTINE": with(scope) _result = _call(); // TODO.
      }
      
      if (_result == false)
      {
        index -= 3;
        return false;
      }
      
      return true;
    },
  
  
    ["TIMEOUT"],
    function()
    {
      return true;
    },
    
    
    ["REG_CALL"],
    function()
    {
      var _register = code[index++];
      var _method = code[index++];
      var _result = undefined;
      with(scope) _result = _method();
      local[_register] = _result;
      return true;
    },
    
    
    ["REG_LOAD"],
    function()
    {
      var _register = code[index++];
      var _value = code[index++];
      local[_register] = _value;
      return true;
    },
    
    
    ["REG_INCR"],
    function()
    {
      ++local[code[index++]];
      return true;
    },
    
    
    ["REG_DECR"],
    function()
    {
      --local[code[index++]];
      return true;
    },
  ]);
  
  
  // Return instruction.
  return instructions[$ _opcode];
}




