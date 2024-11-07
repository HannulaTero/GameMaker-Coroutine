


/// @func CoroutinePrototype(_root);
/// @desc 
/// @param {Struct} _root
function CoroutinePrototype(_root) constructor
{
  static counter = 0;
  
  // Instructions.
  self.root = _root;
  self.code = _root.code;
  self.nodes = _root.nodes;
  self.labels = _root.labels;
  self.options = {};
  self.triggers = {};
  self.count = array_length(code);
  
  // Get the options.
  var _options = _root.define.options;
  self.options.name = _options[$ "name"] ?? $"Coroutine_{counter++}";
  self.options.desc = _options[$ "desc"] ?? "";
  self.options.slot = _options[$ "slot"] ?? 1.0;
  
  // Get the triggers.
  var _define = _root.define;
  self.triggers.onInit = _define[$ "onInit"];
  self.triggers.onYield = _define[$ "onYield"];
  self.triggers.onPause = _define[$ "onPause"];
  self.triggers.onCancel = _define[$ "onCancel"];
  self.triggers.onResume = _define[$ "onResume"];
  self.triggers.onLaunch = _define[$ "onLaunch"];
  self.triggers.onComplete = _define[$ "onComplete"];
  self.triggers.onError = _define[$ "onError"];
  
  
  /// @func Dispatch(_this);
  /// @desc
  /// @param {Struct} _this
  /// @returns {Struct.Coroutine}
  static Dispatch = function(_this=other)
  {
    var _coroutine = new Coroutine(self, _this);
    COROUTINE_ACTIVE.InsertTail(_coroutine);
    return _coroutine;
  };
}