


/// @func CoroutineInstance(_prototype, _this);
/// @desc Creates new executable coroutine instance of given prototype.
/// @param {Struct.CoroutinePrototype} _prototype
/// @param {Any} _this
function CoroutineInstance(_prototype, _this=other) constructor
{
  static counter = 0;
  
  // General variables.
  self.prototype = _prototype;
  self.identifier = counter++;
  self.parent = undefined;
  self.link = new CoroutineDoubleLinkedListNode(self);
  
  
  // Get references to data from the prototype.
  // These should not be modified, otherwise it affects all instances of prototype.
  self.graph = _prototype.graph;
  self.labels = _prototype.labels;
  self.option = _prototype.option;
  self.trigger = _prototype.trigger;
  self.execute = graph.execute;
  self.delayTimer = undefined;
  
  
  // Execution states.
  // Locals are used up-keeping of timers and iterations for the execution.
  // Scope holds variables of coroutine, and reference to original self.
  var _self = self;
  self.local = [];
  self.scope = _prototype.option.scoped ? { this: _this, coroutine: _self } : _this;
  self.childs = { };
  self.result = undefined;
  self.finished = false;
  
  
  // Initialize the coroutine, check whether is subcoroutine.
  // feather ignore GM2043
  Execute(trigger.onInit);
  COROUTINE_LIST_ACTIVE.InsertTail(link);
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
  /// @desc Creates new coroutine instance of same prototype.
  /// @param {Id.Instance|Struct} _this
  /// @returns {Struct.CoroutineInstance}
  static Dispatch = function(_this=other)
  {
    return new CoroutineInstance(prototype, _this);
  };
  
  
  /// @func Execute(_callback);
  /// @desc Executes function in the coroutine's scope.
  /// @param {Function} _callback
  /// @returns {Any}
  static Execute = function(_callback)
  {
    with(scope) return _callback();
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
  
  
  /// @func Finish(_value);
  /// @desc Finishes the coroutine, and calls complete-trigger.
  /// @param {Any} _value
  /// @returns {Struct.CoroutineInstance}
  static Finish = function(_value)
  {
    if (finished == false)
    {
      link.Detach();
      Execute(trigger.onComplete);
      if (parent != undefined)
      {
        // feather ignore GM1041
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
    return Finish(undefined);
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





