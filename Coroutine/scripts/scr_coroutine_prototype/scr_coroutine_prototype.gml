


/// @func CoroutinePrototype(_root);
/// @desc Structure for holding blueprints for creating coroutine-instances.
/// @param {Struct} _root
function CoroutinePrototype(_root) constructor
{
  // Static variables.
  static counter = 0;
  
  
  // Get the instructions.
  self.root = _root;
  self.nodes = _root.nodes;
  self.graph = _root.graph;
  self.label = _root.label;
  
  
  // Get the options.
  var _option = _root.define.option;
  self.option = {};
  with(option)
  {
    name = _option[$ "name"] ?? $"CoroutinePrototype_{counter++}";
    desc = _option[$ "desc"] ?? "";
    slot = _option[$ "slot"] ?? 1.0;
  }
  
  
  // Get the triggers.
  var _nop = function() {};
  var _define = _root.define;
  self.trigger = {};
  with(trigger)
  {
    onInit = _define[$ "onInit"] ?? _nop;
    onYield = _define[$ "onYield"] ?? _nop;
    onPause = _define[$ "onPause"] ?? _nop;
    onCancel = _define[$ "onCancel"] ?? _nop;
    onResume = _define[$ "onResume"] ?? _nop;
    onLaunch = _define[$ "onLaunch"] ?? _nop;
    onComplete = _define[$ "onComplete"] ?? _nop;
    onError = _define[$ "onError"] ?? _nop;
  }
  
  
  /// @func Dispatch(_this);
  /// @desc
  /// @param {Id.Instance|Struct} _this
  /// @returns {Struct.CoroutineInstance}
  static Dispatch = function(_this=other)
  {
    return new CoroutineInstance(self, _this);
  };
}