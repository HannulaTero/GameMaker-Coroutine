

/**
* Creates new active task of given prototype.
*
* @param {Struct.__KorutiiniPrototype}  _prototype
* @param {Struct | Id.Instance}         _this
* @param {Struct}                       _vars
*/
function __KorutiiniTask(_prototype, _this=other, _vars=undefined) constructor
{
  // Static variables.
  static counter      = 0;
  static poolActive   = __KorutiiniRuntime_PoolActive();
  static poolPaused   = __KorutiiniRuntime_PoolPaused();
  static poolDelayed  = __KorutiiniRuntime_PoolDelayed();
  
  
  // Static methods.
  static Cancel       = __KorutiiniTask__Cancel;
  static Destroy      = __KorutiiniTask__Destroy;
  static Dispatch     = __KorutiiniTask__Dispatch;
  static Execute      = __KorutiiniTask__Execute;
  static Get          = __KorutiiniTask__Get;
  static HasChilds    = __KorutiiniTask__HasChilds;
  static HasListeners = __KorutiiniTask__HasListeners;
  static HasRequests  = __KorutiiniTask__HasRequests;
  static IsDelayed    = __KorutiiniTask__IsDelayed;
  static IsFinished   = __KorutiiniTask__IsFinished;
  static IsPaused     = __KorutiiniTask__IsPaused;
  static Pause        = __KorutiiniTask__Pause;
  static Resume       = __KorutiiniTask__Resume;
  static Set          = __KorutiiniTask__Set;
  static toString     = __KorutiiniTask__toString;
  
  
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
  var _self   = self;
  this        = _this;
  local       = [];
  scope       = prototype.scoped ? { this: _this, coroutine: _self } : _this;
  execute     = graph.execute;
  parentTask  = undefined;
  result      = undefined;
  finished    = false;
  delayed     = false;
  paused      = false;
  
  // Child tasks and async requests/listeners.
  childTasks      = ds_map_create();
  childRequests   = ds_map_create();
  childListeners  = ds_map_create();
  
  
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
    static poolActive   = __KorutiiniRuntime_PoolActive();
    static poolPaused   = __KorutiiniRuntime_PoolPaused();
    static poolDelayed  = __KorutiiniRuntime_PoolDelayed();
    
    ds_map_delete(poolDelayed, identifier);
    poolActive[? identifier] = self; 
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
  
  poolActive[? identifier] = self;
  
  if (KORUTIINI_CURRENT_TASK != undefined)
  {
    parentTask = KORUTIINI_CURRENT_TASK;
    parentTask.childTasks[? identifier] = self;
  }
}





