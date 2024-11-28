/// @desc FOREACH.


// There is no foreach -statement in GM, just array_foreach and struct_foreach -functions.
// FOREACH will accept usual iterable items, and iterate each item.
COROUTINE
ON_CLEANUP
  ds_list_destroy(list);
  ds_map_destroy(map);
  buffer_delete(buffer);
  instance_destroy(obj_example_instance);

BEGIN 
  // Initializing different datastructures, which are acceptable.
  array = [10, 20, 30, 40];
  struct = { text: "hello world!", number: 123, a: 0, b: 1, c: 2 }; 
  text = "HELLO WORLD!";
  
  list = ds_list_create();
  ds_list_add(list, -1, -2, -3, -4);
  
  map = ds_map_create();
  ds_map_add(map, "apple", 200);
  ds_map_add(map, "orange", 400);
  ds_map_add(map, "kiwi", 600);
  ds_map_add(map, "grape fruit", 550);
  
  dtype = buffer_f64;
  dsize = buffer_sizeof(dtype);
  bytes = 64;
  buffer = buffer_create(bytes, buffer_fixed, dsize);
  buffer_seek(buffer, buffer_seek_start, 0);
  repeat(bytes / dsize) 
  {
    buffer_write(buffer, dtype, random(256.0));
  }
  
  repeat(5)
  {
    instance_create_depth(random(256), random(256), 0, obj_example_instance);
  }
  

  // Iterating over array.
  PRINT "iterating over array.";
  FOREACH key, value IN array THEN
    show_debug_message($"array[{key}] = {value};");
    DELAY 3 FRAMES
  END

  // Iterating keys are both optional.
  PRINT "iterating over another array.";
  FOREACH value IN [11, 22, 33, 44] THEN
    show_debug_message($"item in array: {value}");
    DELAY 3 FRAMES
  END

  // Iterating keys can also be renamed.
  PRINT "iterating over ds_map.";
  FOREACH fruit: key, cost: value IN map THEN
    show_debug_message($"map[? {fruit}] = {cost};");
    DELAY 3 FRAMES
  END

  // If you have nested foreach, then renaming identifiers is useful.
  PRINT "iterating over struct.";
  FOREACH key, value IN struct THEN
    show_debug_message($"struct.{key} = {value};");
    DELAY 3 FRAMES
  END
  
  // 
  PRINT "iterating over list.";
  FOREACH key, value IN list THEN
    show_debug_message($"list[| {key}] = {value};");
    DELAY 3 FRAMES
  END
  
  // Iterating over string puts index and character as key-value.
  PRINT "iterating over string.";
  FOREACH key, value IN text THEN
    show_debug_message($"string_char_at(text, {key}) = '{value}';");
    DELAY 3 FRAMES
  END
  
  // You can also iterate over number by giving it as iterable.
  PRINT "iterating over number.";
  FOREACH key, value IN 10 THEN
    show_debug_message($"number {key} = '{value}';");
    DELAY 3 FRAMES
  END
  
  // But you can also give numeric range, which is iterated over.
  // This you can specify start and end values, and what is step -size.
  PRINT "iterating over range.";
  FOREACH key, value IN RANGE(40, 10, -3) THEN
    show_debug_message($"range {key} = {value};");
    DELAY 3 FRAMES
  END
  
  // Iterating over buffer just gives raw bytes.
  PRINT "iterating over buffer.";
  FOREACH key, value IN buffer THEN
    show_debug_message($"buffer_peek(buffer, buffer_u8, {key}) = {value};");
    DELAY 3 FRAMES
  END
  
  // But you can give specific way of viewing buffer, so it knows how to read values.
  // VIEW has optional arguments and ways to specify iteration.
  PRINT "iterating over buffer viewing values as buffer_f64.";
  FOREACH key, value IN VIEW(buffer, buffer_f64) THEN
    show_debug_message($"buffer_peek(buffer, buffer_f64, {key}) = {value};");
    DELAY 3 FRAMES
  END
  
  // Finally you can also give objects as iterable.
  PRINT "iterating over instances of object.";
  FOREACH key, value IN obj_example_instance THEN
    show_debug_message($"instance[{key}].x = {value.x};");
    show_debug_message($"instance[{key}].y = {value.y};");
    DELAY 3 FRAMES
  END


FINISH DISPATCH 













