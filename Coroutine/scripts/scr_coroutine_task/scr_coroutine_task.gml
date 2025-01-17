


/// @func CoroutineTask(_prototype, _this, _vars);
/// @desc Creates new active task of given prototype.
/// @param {Struct.CoroutinePrototype} _prototype
/// @param {Struct|Id.Instance} _this
/// @param {Struct} _vars
// feather ignore GM2043
// feather ignore GM1063
function CoroutineTask(_prototype, _this=other, _vars=undefined) constructor
{
  static counter = 0;
  identifier = counter++;
  
  // Get the values from the prototype.
  prototype = _prototype;
  graph = _prototype.graph;
  labels = _prototype.labels;
  final = _prototype.final;


  // Execution states.
  // Locals are used up-keeping of timers and iterations for the execution.
  // Scope holds variables of coroutine, and reference to original self.
  var _self = self;
  this = _this;
  local = [];
  scope = prototype.scoped ? { this: _this, coroutine: _self } : _this;
  execute = graph.execute;
  childTasks = ds_map_create();
  asyncRequests = ds_map_create();
  asyncListeners = ds_map_create();
  parent = undefined;
  result = undefined;
  finished = false;
  delayed = false;
  paused = false;
  
  
  // Triggers.
  // Setup scoped methods, as there are limited amount of them.
  onInit      = method(scope, prototype.onInit);
  onYield     = method(scope, prototype.onYield);
  onPause     = method(scope, prototype.onPause);
  onLaunch    = method(scope, prototype.onLaunch);
  onResume    = method(scope, prototype.onResume);
  onCancel    = method(scope, prototype.onCancel);
  onComplete  = method(scope, prototype.onComplete);
  onCleanup   = method(scope, prototype.onCleanup);
  onError     = method(scope, prototype.onError);

  
  // Set up delayer using separate time source, which is reconfigurated whenever necessary.
  // This seems to be slightly faster than using call_later (less GC'ing?).
  delayResume = function() 
  { 
    ds_map_delete(COROUTINE_POOL_DELAYED, identifier);
    COROUTINE_POOL_ACTIVE[? identifier] = self; 
    delayed = false;
  };
  delaySource = time_source_create(time_source_game, 1, time_source_units_seconds, delayResume);
  
  
  // Activate the coroutine for execution.
  // Do the initialization and setup the variables.
  // If other coroutine is already in execution, this is subcoroutine.
  onInit();
  if (_vars != undefined) 
  {
    struct_foreach(_vars, function(_key, _item)
    {
      scope[$ _key] = _item;
    });
  }
  COROUTINE_POOL_ACTIVE[? identifier] = self;
  if (COROUTINE_CURRENT_TASK != undefined)
  {
    parent = COROUTINE_CURRENT_TASK;
    parent.childTasks[? identifier] = self;
  }
  
  
  /// @func Dispatch(_this, _vars);
  /// @desc Creates new active task of same prototype.
  /// @param {Id.Instance|Struct} _this
  /// @param {Struct} _vars
  /// @returns {Struct.CoroutineTask}
  static Dispatch = function(_this=other, _vars=undefined) 
  { 
    return prototype.Dispatch(_this, _vars); 
  };
  
  
  /// @func Get();
  /// @desc Returns current result of coroutine.
  /// @returns {Any}
  static Get = function() 
  { 
    return result;
  };
  
  
  /// @func Execute(_func);
  /// @desc Executes function in the coroutine's scope.
  /// @param {Function} _func
  static Execute = function(_func) 
  {
    with scope return _func();
  };
  
  
  /// @func Pause();
  /// @desc 
  static Pause = function() 
  {
    // Can't pause if it's already paused or destroyed.
    if (finished == true) 
    || (paused == true)
      return self;
      
    // Take a undeterminated break.
    paused = true;
    onPause();
    ds_map_delete(COROUTINE_POOL_ACTIVE, identifier);
    ds_map_delete(COROUTINE_POOL_DELAYED, identifier);
    COROUTINE_POOL_PAUSED[? identifier] = self;
    if (time_source_get_state(delaySource) != time_source_state_stopped)
    {
      time_source_stop(delaySource);
    }
    
    return self;
  };
  
  
  /// @func Resume();
  /// @desc 
  static Resume = function() 
  { 
    // Can't resume if it's not paused or destroyed.
    if (finished == true) 
    || (delayed == true)
    || (paused == false)
      return self;
      
    // Return to the usual action.
    paused = false;
    onResume();
    ds_map_delete(COROUTINE_POOL_PAUSED, identifier);
    COROUTINE_POOL_ACTIVE[? identifier] = self;
    return self;
  };
  
  
  /// @func Cancel();
  /// @desc Destroyes the coroutine, and calls onCancel -trigger.
  static Cancel = function() 
  {
    // Can't cancel if already finished.
    if (finished == true)
      return self;
    
    // Trigger and remove itself.
    onCancel();
    Destroy();
    return self; 
  };
  
  
  /// @func hasChilds();
  /// @desc 
  /// @returns {Bool}
  static hasChilds = function() 
  { 
    return (ds_map_size(childTasks) > 0);
  };
  
  
  /// @func hasRequests();
  /// @desc Whether has pending async requests.
  /// @returns {Bool}
  static hasRequests = function() 
  { 
    return (ds_map_size(asyncRequests) > 0);
  };
  
  
  /// @func hasListeners();
  /// @desc Whether has async listeners.
  /// @returns {Bool}
  static hasListeners = function() 
  { 
    return (ds_map_size(asyncListeners) > 0);
  };
  
  
  /// @func isPaused();
  /// @desc 
  /// @returns {Bool}
  static isPaused = function() 
  {
    return paused; 
  };
  
  
  /// @func isDelayed();
  /// @desc 
  /// @returns {Bool}
  static isDelayed = function() 
  {
    return delayed; 
  };
  
  
  /// @func isFinished();
  /// @desc 
  /// @returns {Bool}
  static isFinished = function() 
  { 
    return finished;
  };
  
  
  /// @func Destroy();
  /// @desc Directly destroyes the coroutine without triggering onCancel.
  static Destroy = function() 
  { 
    // Can't destroy what has already been destroyed.
    if (finished == true) 
      return self;
    
    // Trigger Cleanup.
    onCleanup();
    
    // Put itself into right state, and remove data.
    paused = false;
    delayed = false;
    finished = true;
    ds_map_delete(COROUTINE_POOL_ACTIVE, identifier);
    ds_map_delete(COROUTINE_POOL_PAUSED, identifier);
    ds_map_delete(COROUTINE_POOL_DELAYED, identifier);
    
    // Remove itself from all childs.
    var _childTasks = ds_map_keys_to_array(childTasks);
    array_foreach(_childTasks, function(_identifier, i)
    {
      childTasks[? _identifier].parent = undefined;
    });
    array_resize(_childTasks, 0);
    ds_map_destroy(childTasks);
    
    // Remove all async requests.
    var _asyncRequests = ds_map_keys_to_array(asyncRequests);
    array_foreach(_asyncRequests, function(_identifier, i)
    {
      asyncRequests[? _identifier].Destroy();
    });
    array_resize(_asyncRequests, 0);
    ds_map_destroy(asyncRequests);
    
    // Remove all async listeners.
    var _asyncListeners = ds_map_keys_to_array(asyncListeners);
    array_foreach(_asyncListeners, function(_identifier, i)
    {
      asyncListeners[? _identifier].Destroy();
    });
    array_resize(_asyncListeners, 0);
    ds_map_destroy(asyncListeners);
    
    // Destroy the delay-timer.
    time_source_destroy(delaySource);
    if (parent != undefined) 
    {
      ds_map_delete(parent.childTasks, identifier);
    }
    
    return self;
  };
  
  
  /// @func toString();
  /// @desc
  /// @returns {String}
  static toString = function()
  {
    return string(identifier);
  };
}





