/// @desc FOREACH IN BUFFER (RAW).


COROUTINE
  ON_CLEANUP
    buffer_delete(buffer);

  BEGIN 
    // Initializing iterable datastructures.
    dtype = buffer_f64;
    dsize = buffer_sizeof(dtype);
    bytes = 64;
    buffer = buffer_create(bytes, buffer_fixed, dsize);
    buffer_seek(buffer, buffer_seek_start, 0);
    repeat(bytes / dsize) 
    {
      buffer_write(buffer, dtype, random(256.0));
    }
  
  
    // Iterating over buffer just gives raw bytes us usigned 8bit integers.
    PRINT "iterating over buffer as raw bytes.";
    FOREACH key, value IN buffer THEN
      show_debug_message($"buffer_peek(buffer, buffer_u8, {key}) = {value};");
      DELAY 3 FRAMES
    END
    PRINT "done.";

  
  FINISH 
DISPATCH 













