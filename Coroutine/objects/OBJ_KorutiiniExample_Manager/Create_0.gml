/// @desc EXAMPLES.
show_debug_overlay(true, true);
KORUTIINI_SINGLETON


// Set listeners for each async event.
var _asyncListeners     = __KorutiiniRuntime_AsyncListeners();
var _asyncListenersList = ds_map_keys_to_array(_asyncListeners);
array_foreach(_asyncListenersList, function(_type, i)
{
  ASYNC_LISTENER type: _type
  ON_LISTEN 
    KorutiiniExample_Log($"===============================================");
    KorutiiniExample_Log($"Async Listener");
    KorutiiniExample_Log($" - event event   : {event_type}");
    KorutiiniExample_Log($" - event number  : {event_number}");
    if (async_load != -1)
    && (async_load != undefined)
    {
      KorutiiniExample_Log($" - async status  : {async_load[? "status"]}");
    }
    KorutiiniExample_Log($"===============================================");
  ASYNC_END
});
array_resize(_asyncListenersList, 0);


// For logging out the console messages.
alarm[1] = 300;
self.logs = [ ];
self.Log = function(_message)
{
  show_debug_message(_message);
  array_insert(self.logs, 0, _message);
  var _maxCount = 64;
  var _count = array_length(self.logs);
  if (_count > _maxCount)
  {
    array_delete(self.logs, -1, (_maxCount - _count));
  }
  alarm[1] = 300;
};



// Set drawing location.
xstart = room_width * 0.4;
ystart = room_height * 0.4;
x = xstart;
y = ystart;


// Group construct.
self.Group = function(_name, _examples) constructor
{
  name = _name;
  index = 0;
  examples = _examples;
  
  static Get = function()
  {
    return examples[index]; 
  };
};


// Get all example groups.
groups = [
  new Group("Basics", [
    OBJ_KorutiiniExample_Basics00_HelloWorld,
    OBJ_KorutiiniExample_Basics01_Scope,
    OBJ_KorutiiniExample_Basics02_Settings,
    OBJ_KorutiiniExample_Basics03_Prototype,
    OBJ_KorutiiniExample_Basics04_Dispatch,
    OBJ_KorutiiniExample_Basics05_Triggers,
  ]), 
  new Group("Halting", [
    OBJ_KorutiiniExample_Halting00_Pass,
    OBJ_KorutiiniExample_Halting01_Yield,
    OBJ_KorutiiniExample_Halting02_Pause,
    OBJ_KorutiiniExample_Halting03_Delay,
    OBJ_KorutiiniExample_Halting04_Set,
    OBJ_KorutiiniExample_Halting05_Await,
  ]), 
  new Group("ControlFlow", [
    OBJ_KorutiiniExample_ControlFlow00_IfElse,
    OBJ_KorutiiniExample_ControlFlow01_IfChain,
    OBJ_KorutiiniExample_ControlFlow02_Switch,
    OBJ_KorutiiniExample_ControlFlow03_Loop,
    OBJ_KorutiiniExample_ControlFlow04_While,
    OBJ_KorutiiniExample_ControlFlow05_Repeat,
    OBJ_KorutiiniExample_ControlFlow06_DoUntil,
    OBJ_KorutiiniExample_ControlFlow07_For,
    OBJ_KorutiiniExample_ControlFlow08_Goto,
  ]),
  new Group("Foreach", [
    OBJ_KorutiiniExample_Foreach00_Array,
    OBJ_KorutiiniExample_Foreach01_Struct,
    OBJ_KorutiiniExample_Foreach02_DSList,
    OBJ_KorutiiniExample_Foreach03_DSMap,
    OBJ_KorutiiniExample_Foreach04_String,
    OBJ_KorutiiniExample_Foreach05_Number,
    OBJ_KorutiiniExample_Foreach06_Range,
    OBJ_KorutiiniExample_Foreach07_Buffer,
    OBJ_KorutiiniExample_Foreach08_BufferView,
    OBJ_KorutiiniExample_Foreach09_Object,
  ]),
  new Group("Async", [
    OBJ_KorutiiniExample_Async00_Message,
    OBJ_KorutiiniExample_Async01_SoundEnd,
    OBJ_KorutiiniExample_Async02_GetString,
    OBJ_KorutiiniExample_Async03_GetIntegers,
    OBJ_KorutiiniExample_Async04_HTTPGet,
    OBJ_KorutiiniExample_Async05_BufferSave,
    OBJ_KorutiiniExample_Async06_BufferLoad,
    OBJ_KorutiiniExample_Async07_AudioRecording,
  ]),
  new Group("Misc", [
    OBJ_KorutiiniExample_Misc00_Syntax,
    OBJ_KorutiiniExample_Misc01_Subtasks,
    OBJ_KorutiiniExample_Misc02_1000_Instances,
    OBJ_KorutiiniExample_Misc03_Surface_Sort,
    OBJ_KorutiiniExample_Misc04_SpriteBroadcast,
  ]),
];


// Set up the selector.
index = 0;
count = array_length(groups);
example = undefined;


// For calculating average FPS.
fpsFrames = 15;
fpsAvg = 0.0;
fpsSum = 0.0;
alarm[0] = fpsFrames;


