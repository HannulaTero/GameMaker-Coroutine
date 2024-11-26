/// @desc EXAMPLES.

COROUTINE_SINGLETON

show_debug_overlay(true, true);
xstart = room_width * 0.50;
ystart = room_height * 0.40;
x = xstart;
y = ystart;

// Get the examples.
examples = {
  basics : [
    obj_example_basics_00_hello_world,
    obj_example_basics_01_scope,
    obj_example_basics_02_settings,
    obj_example_basics_03_prototype,
    obj_example_basics_04_dispatch,
    obj_example_basics_05_triggers,
  ],
  async : [
    obj_example_async_00_message,
    obj_example_async_01_sound_end,
    obj_example_async_02_get_string,
    obj_example_async_03_get_integers,
    obj_example_async_04_http_get,
    obj_example_async_05_buffer_save,
    obj_example_async_06_buffer_load,
    obj_example_async_07_audio_recording,
    obj_example_async_XX_listen_http,
  ],
  keywords : [
    obj_example_keywords_00_pass,
    obj_example_keywords_01_yield,
    obj_example_keywords_02_pause,
    obj_example_keywords_03_delay,
    obj_example_keywords_04_set,
  ]
};


// Set up the selector.
groupName = "basics";
groupNames = struct_get_names(examples);
groupNames = array_filter(groupNames, function(_name, i) 
{ 
  return (array_length(examples[$ _name]) > 0); 
});
array_sort(groupNames, true);

groupCount = array_length(groupNames);
groupIndex = array_find_index(groupNames, function(_key, i) 
{
  return (_key == groupName);
});

groupExampleIndex = {};
array_foreach(groupNames, function(_key, i) 
{ 
  groupExampleIndex[$ _key] = 0; 
});

exampleIndex = groupExampleIndex[$ groupName];
exampleActive = examples[$ groupName][exampleIndex];
exampleName = object_get_name(exampleActive);



