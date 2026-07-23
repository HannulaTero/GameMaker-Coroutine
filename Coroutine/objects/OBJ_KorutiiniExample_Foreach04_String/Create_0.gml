/// @desc FOREACH IN STRING.



KORUTIINI BEGIN 

  text = "HELLO WORLD! Have a good day :)";

  // Iterating over string puts index and character as key-value.
  PRINT $"iterating over string: '{text}'.";
  FOREACH key, value IN text THEN
    KorutiiniExample_Log($"string_char_at(text, {key}) = '{value}';");
    DELAY 3 FRAMES
  END
  PRINT "done.";


FINISH DISPATCH 













