


/// @func Coroutine(_prototype, _this);
/// @desc 
/// @param {Struct.CoroutinePrototype} _prototype
/// @param {Any} _this
function Coroutine(_prototype, _this=other) constructor
{
  // Get references to data from the prototype.
  // These should not be modified, as they affect all.
  self.code = _prototype.code;
  self.labels = _prototype.labels;
  self.options = _prototype.options;
  self.triggers = _prototype.triggers;
  self.count = _prototype.count;
  
  
  // Execution states.
  // Next & Prev are for double linked list.
  // Index tells the current position in instructions/code.
  // Children tells coroutines created within coroutine, which can be used to await them.
  // Locals are used up-keeping of timers and iterations for the execution.
  // Scope holds variables of coroutine, and reference to original self.
  self.next = undefined;
  self.prev = undefined;
  self.index = 0;
  self.local = [];
  self.child = [];
  self.scope = { this: _this, coroutine: self };
  self.pointBreak = [];
  self.pointContinue = [];
  self.paused = false;
  self.finished = true;
  
  
  /// @func Dispatch(_this);
  /// @desc Creates new instance of same prototype.
  /// @param {Struct} _this
  /// @returns {Struct.Coroutine}
  self.Dispatch = function(_this=other)
  {
    var _coroutine = new Coroutine(static_get(self), _this);
    COROUTINE_ACTIVE.InsertTail(_coroutine);
    return _coroutine;
  };
  
  
  self.Execute = function(_func)
  {
    if (_func == undefined) return;
    with(scope) return _func();
  };
  
  
  self.Pause = function()
  {
    if (paused == false)
    && (finished == false)
    {
      COROUTINE_ACTIVE.Detach(self);
      COROUTINE_PAUSED.InsertTail(self);
      Execute(triggers.onPause);
    }
    self.paused = true;
    return self;
  };
  
  
  self.Resume = function()
  {
    if (paused == true)
    && (finished == false)
    {
      COROUTINE_PAUSED.Detach(self);
      COROUTINE_ACTIVE.InsertTail(self);
      Execute(triggers.onResume);
    }
    self.paused = false;
    return self;
  };
  
  
  self.isPaused = function()
  {
    return paused;
  };
  
  
  self.isFinished = function()
  {
    return finished;
  };
  
  
  self.Cancel = function()
  {
    self.index = count;
    if (finished == false)
    {
      COROUTINE_PAUSED.Detach(self);
      COROUTINE_ACTIVE.InsertTail(self);
      Execute(triggers.onCancel);
    }
    self.finished = true;
    return self;
  };
}





