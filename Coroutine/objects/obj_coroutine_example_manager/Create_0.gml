/// @desc EXAMPLES.

COROUTINE_SINGLETON

show_debug_overlay(true, true);
xstart = room_width * 0.4;
ystart = room_height * 0.4;
x = xstart;
y = ystart;


// Group construct.
Group = function(_name, _examples) constructor
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
  new Group("basics", [
    obj_example_basics_00_hello_world,
    obj_example_basics_01_scope,
    obj_example_basics_02_settings,
    obj_example_basics_03_prototype,
    obj_example_basics_04_dispatch,
    obj_example_basics_05_triggers,
  ]), 
  new Group("keywords", [
    obj_example_keywords_00_pass,
    obj_example_keywords_01_yield,
    obj_example_keywords_02_pause,
    obj_example_keywords_03_delay,
    obj_example_keywords_04_set,
  ]), 
  new Group("async", [
    obj_example_async_00_message,
    obj_example_async_01_sound_end,
    obj_example_async_02_get_string,
    obj_example_async_03_get_integers,
    obj_example_async_04_http_get,
    obj_example_async_05_buffer_save,
    obj_example_async_06_buffer_load,
    obj_example_async_07_audio_recording,
  ]),
];

// Set up the selector.
index = 0;
count = array_length(groups);
example = undefined;



