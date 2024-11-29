/// @desc FOREACH IN ARRAY.


// There is no foreach -statement in GM, just array_foreach and struct_foreach -functions.
// FOREACH will accept usual iterable items, and iterate each item.
COROUTINE BEGIN 

  array = [10, 20, 30, 40, 50, 60, 70, 80, 90];

  // Iterating over array.
  FOREACH key, value IN array THEN
    show_debug_message($"array[{key}] = {value};");
    DELAY 3 FRAMES
  END
  show_debug_message("First array done!");
  

  // Iterator keys are both optional.
  FOREACH IN array THEN
    show_debug_message($"Why iterate over if you don't use iterator keys?");
    DELAY 3 FRAMES
  END
  show_debug_message("Second array done!");
  

  // Both iterator keys can also be renamed.
  FOREACH i: key, text: value IN ["HELLO", "WORLD", "!", "GOOD", "DAY"] THEN
    show_debug_message($"[{i}] {text}");
    DELAY 3 FRAMES
  END
  show_debug_message("Third array done!");

FINISH DISPATCH 













