


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
  var _define = _root.define;
  self.trigger = {};
  with(trigger)
  {
    onInit = _define[$ "onInit"];
    onYield = _define[$ "onYield"];
    onPause = _define[$ "onPause"];
    onCancel = _define[$ "onCancel"];
    onResume = _define[$ "onResume"];
    onLaunch = _define[$ "onLaunch"];
    onComplete = _define[$ "onComplete"];
    onError = _define[$ "onError"];
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