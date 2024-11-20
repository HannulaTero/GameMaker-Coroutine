


/// @func CoroutineInstance(_prototype, _this);
/// @desc Creates new executable coroutine instance of given prototype.
/// @param {Struct.CoroutinePrototype} _prototype
/// @param {Any} _this
function CoroutineInstance(_prototype, _this=other) constructor
{
  // General variables.
  self.prototype = _prototype;
  self.identifier = string(ptr(self));
  self.parent = undefined;
  self.link = new CoroutineDoubleLinkedListNode(self);
  
  
  // Get references to data from the prototype.
  // These should not be modified, otherwise it affects all instances of prototype.
  self.graph = _prototype.graph;
  self.label = _prototype.label;
  self.option = _prototype.option;
  self.trigger = _prototype.trigger;
  self.execute = graph.execute;
  
  
  // Execution states.
  // Locals are used up-keeping of timers and iterations for the execution.
  // Scope holds variables of coroutine, and reference to original self.
  var _self = self;
  self.local = [];
  self.scope = { this: _this, coroutine: _self };
  self.childs = { };
  self.result = undefined;
  self.finished = false;
  
  
  // Call initializer -trigger of the coroutine.
  var _onInit = trigger.onInit;
  if (_onInit != undefined)
  {
    with(scope) _onInit();
  }
  
  
  // Add to the instances list.
  COROUTINE_LIST_ACTIVE.InsertTail(link);
  
  
  // Mark the as children, if initializd within coroutine.
  if (COROUTINE_CURRENT != undefined)
  {
    parent = COROUTINE_CURRENT;
    struct_set(parent.childs, identifier, self);
  }
  
  /// @func Get();
  /// @desc Returns current result of coroutine.
  /// @returns {Any}
  static Get = function()
  {
    return result;
  };
  
  /// @func Dispatch(_this);
  /// @desc Creates new instance of same prototype.
  /// @param {Id.Instance|Struct} _this
  /// @returns {Struct.CoroutineInstance}
  static Dispatch = function(_this=other)
  {
    return new CoroutineInstance(prototype, _this);
  };
  
  
  /// @func Execute(_func);
  /// @desc 
  /// @param {Function} _func
  /// @returns {Any}
  static Execute = function(_func)
  {
    with(scope) return _func();
  };
  
  
  /// @func Pause();
  /// @desc 
  /// @returns {Struct.CoroutineInstance}
  static Pause = function()
  {
    COROUTINE_LIST_PAUSED.InsertTail(link);
    Execute(trigger.onPause);
    return self;
  };
  
  
  /// @func Resume();
  /// @desc 
  /// @returns {Struct.CoroutineInstance}
  static Resume = function()
  {
    COROUTINE_LIST_ACTIVE.InsertTail(link);
    Execute(trigger.onResume);
    return self;
  };
  
  
  /// @func Restart();
  /// @desc Restarts the coroutine execution.
  /// @returns {Struct.CoroutineInstance}
  static Restart = function()
  {
    COROUTINE_LIST_ACTIVE.InsertTail(link);
    self.execute = graph.execute;
    self.finished = false;
    return self;
  };
  
  
  /// @func Return(_value);
  /// @desc Finishes the coroutine, and calls complete-trigger.
  /// @param {Any} _value
  /// @returns {Struct.CoroutineInstance}
  static Return = function(_value)
  {
    if (finished == false)
    {
      link.Detach();
      Execute(trigger.onComplete);
      if (parent != undefined)
      {
        struct_remove(parent.childs, identifier);
      }
    }
    else
    {
      show_debug_message("Coroutine is already finished.");
    }
    self.finished = true;
    self.result = _value;
    return self;
  };
  
  
  /// @func Cancel();
  /// @desc Cancels the coroutine, and calls both complete and cancel-trigger.
  /// @returns {Struct.CoroutineInstance}
  static Cancel = function()
  {
    Execute(trigger.onCancel);
    return Return(undefined);
  };
  
  
  /// @func hasChilds();
  /// @desc 
  /// @returns {Bool}
  static hasChilds = function()
  {
    return (struct_names_count(childs) > 0);
  };
  
  
  /// @func isPaused();
  /// @desc 
  /// @returns {Bool}
  static isPaused = function()
  {
    return (link.list == COROUTINE_LIST_PAUSED);
  };
  
  
  /// @func isFinished();
  /// @desc 
  /// @returns {Bool}
  static isFinished = function()
  {
    return finished;
  };
}





