

/**
* Creates new active task of given prototype.
*
* @param {Struct.__CoroutinePrototype}  _prototype
* @param {Struct | Id.Instance}         _this
* @param {Struct}                       _vars
*/
function __CoroutineTask(_prototype, _this=other, _vars=undefined) constructor
{
  // Static variables.
  static counter = 0;
  
  
  // Static methods.
  static Cancel       = __CoroutineTask__Cancel;
  static Destroy      = __CoroutineTask__Destroy;
  static Dispatch     = __CoroutineTask__Dispatch;
  static Execute      = __CoroutineTask__Execute;
  static Get          = __CoroutineTask__Get;
  static HasChilds    = __CoroutineTask__HasChilds;
  static HasListeners = __CoroutineTask__HasListeners;
  static HasRequests  = __CoroutineTask__HasRequests;
  static IsDelayed    = __CoroutineTask__IsDelayed;
  static IsFinished   = __CoroutineTask__IsFinished;
  static IsPaused     = __CoroutineTask__IsPaused;
  static Pause        = __CoroutineTask__Pause;
  static Resume       = __CoroutineTask__Resume;
  static Set          = __CoroutineTask__Set;
  static toString     = __CoroutineTask__toString;
  
  
  // Unique identifier for tasks.
  identifier = counter++;
  
  
  // Get the values from the prototype.
  prototype = _prototype;
  graph     = _prototype.graph;
  labels    = _prototype.labels;
  final     = _prototype.final;


  // Execution states.
  // Locals are used up-keeping of timers and iterations for the execution.
  // Scope holds variables of coroutine, and reference to original self.
  var _self = self;
  this      = _this;
  local     = [];
  scope     = prototype.scoped ? { this: _this, coroutine: _self } : _this;
  execute   = graph.execute;
  childTasks = ds_map_create();
  asyncRequests = ds_map_create();
  asyncListeners = ds_map_create();
  parent    = undefined;
  result    = undefined;
  finished  = false;
  delayed   = false;
  paused    = false;
  
  
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
}





