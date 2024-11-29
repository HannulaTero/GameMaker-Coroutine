
/// @func CoroutinePrototype(_root);
/// @desc Structure for holding blueprints for creating coroutine -tasks.
/// @param {Struct} _root
function CoroutinePrototype(_root) constructor
{
  // Static variables.
  static counter = 0;
  
  
  // Get the instructions.
  root = _root;
  nodes = _root.nodes;
  graph = _root.graph;
  final = _root.final;
  labels = _root.labels;
  
  
  // Get the options.
  var _option = _root.define.option;
  name    = _option[$ "name"]   ?? $"CoroutinePrototype_{counter++}";
  desc    = _option[$ "desc"]   ?? "";
  slot    = _option[$ "slot"]   ?? 1.0;
  scoped  = _option[$ "scoped"] ?? true;
  
  
  // Get the triggers.
  var _nop = function() {};
  var _define = _root.define;
  onInit      = _define[$ "onInit"]     ?? _nop;
  onYield     = _define[$ "onYield"]    ?? _nop;
  onPause     = _define[$ "onPause"]    ?? _nop;
  onLaunch    = _define[$ "onLaunch"]   ?? _nop;
  onResume    = _define[$ "onResume"]   ?? _nop;
  onCancel    = _define[$ "onCancel"]   ?? _nop;
  onComplete  = _define[$ "onComplete"] ?? _nop;
  onCleanup   = _define[$ "onCleanup"] ?? _nop;
  onError     = _define[$ "onError"]    ?? _nop;
  
  
  /// @func Dispatch(_this, _scope);
  /// @desc Creates new active task of prototype.
  /// @param {Id.Instance|Struct} _this
  /// @param {Struct} _vars
  static Dispatch = function(_this=other, _vars=undefined) 
  { 
    return new CoroutineTask(self, _this, _vars); 
  };
}



