/// @desc FOREACH IN STRING.



COROUTINE BEGIN 

  text = "HELLO WORLD! Have a good day :)";

  // Iterating over string puts index and character as key-value.
  PRINT $"iterating over string: '{text}'.";
  FOREACH key, value IN text THEN
    show_debug_message($"string_char_at(text, {key}) = '{value}';");
    DELAY 3 FRAMES
  END
  PRINT "done.";


FINISH DISPATCH 













