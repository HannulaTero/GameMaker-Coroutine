/// @desc EXAMPLES.
show_debug_overlay(true, true);
COROUTINE_SINGLETON


// Set listeners for each async event.
array_foreach(ds_map_keys_to_array(COROUTINE_ASYNC_LISTENERS), function(_type, i)
{
  ASYNC_LISTENER type: _type
  ON_LISTEN 
    show_debug_message($"===============================================");
    show_debug_message($"Async Listener");
    show_debug_message($" - event event   : {event_type}");
    show_debug_message($" - event number  : {event_number}");
    show_debug_message($" - async status  : {async_load[? "status"]}");
    show_debug_message($"===============================================");
  ASYNC_END
});


// Set drawing location.
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
  new Group("halting", [
    obj_example_halting_00_pass,
    obj_example_halting_01_yield,
    obj_example_halting_02_pause,
    obj_example_halting_03_delay,
    obj_example_halting_04_set,
    obj_example_halting_05_await,
  ]), 
  new Group("controlflow", [
    obj_example_controlflow_00_if_else,
    obj_example_controlflow_01_if_chain,
    obj_example_controlflow_02_switch,
    obj_example_controlflow_03_loop,
    obj_example_controlflow_04_while,
    obj_example_controlflow_05_repeat,
    obj_example_controlflow_06_do_until,
    obj_example_controlflow_07_for,
    obj_example_controlflow_08_goto,
  ]),
  new Group("foreach", [
    obj_example_foreach_00_array,
    obj_example_foreach_01_struct,
    obj_example_foreach_02_ds_list,
    obj_example_foreach_03_ds_map,
    obj_example_foreach_04_string,
    obj_example_foreach_05_number,
    obj_example_foreach_06_range,
    obj_example_foreach_07_buffer,
    obj_example_foreach_08_buffer_view,
    obj_example_foreach_09_object,
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
  new Group("misc", [
    obj_example_misc_00_syntax,
    obj_example_misc_01_subtasks,
    obj_example_misc_02_1000_instances,
    obj_example_misc_03_surface_sort,
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


