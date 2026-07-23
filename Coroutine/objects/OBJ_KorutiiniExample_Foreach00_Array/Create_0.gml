/// @desc FOREACH IN ARRAY.


// There is no foreach -statement in GM, just array_foreach and struct_foreach -functions.
// FOREACH will accept usual iterable items, and iterate each item.
KORUTIINI BEGIN 

  array = [10, 20, 30, 40, 50, 60, 70, 80, 90];

  // Iterating over array.
  FOREACH key, value IN array THEN
    KorutiiniExample_Log($"array[{key}] = {value};");
    DELAY 3 FRAMES
  END
  KorutiiniExample_Log("First array done!");
  

  // Iterator keys are both optional.
  FOREACH IN array THEN
    KorutiiniExample_Log($"Why iterate over if you don't use iterator keys?");
    DELAY 3 FRAMES
  END
  KorutiiniExample_Log("Second array done!");
  

  // Both iterator keys can also be renamed.
  FOREACH i: key, text: value IN ["HELLO", "WORLD", "!", "GOOD", "DAY"] THEN
    KorutiiniExample_Log($"[{i}] {text}");
    DELAY 3 FRAMES
  END
  KorutiiniExample_Log("Third array done!");

FINISH DISPATCH 













