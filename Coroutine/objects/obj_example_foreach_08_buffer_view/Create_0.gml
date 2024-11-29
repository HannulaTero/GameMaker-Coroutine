/// @desc FOREACH IN VIEW.


COROUTINE
  ON_CLEANUP
    buffer_delete(buffer);

  BEGIN 
    // Initializing iterable datastructures.
    dtype = buffer_f64;
    dsize = buffer_sizeof(dtype);
    bytes = 256;
    buffer = buffer_create(bytes, buffer_fixed, dsize);
    buffer_seek(buffer, buffer_seek_start, 0);
    repeat(bytes / dsize) 
    {
      buffer_write(buffer, dtype, random(256.0));
    }
  
  
  // Usually you have specific datatype you are using for iteration, so raw bytes are not usable.
  // VIEW is meant to provide way how raw bytes should be read and iterated over.
  // Index will not be byte-offset, but instead item index.
  PRINT "iterating over buffer viewing values as buffer_f64.";
  FOREACH key, value IN VIEW(buffer, dtype) THEN
    show_debug_message($"buffer_peek(buffer, buffer_f64, {key}) = {value};");
    DELAY 3 FRAMES
  END
  PRINT "done.";


  // You can iterate over same buffer with different "views"
  PRINT "iterating over same buffer, but viewing values as buffer_u32.";
  FOREACH key, value IN VIEW(buffer, buffer_u32) THEN
    show_debug_message($"buffer_peek(buffer, buffer_u32, {key}) = {value};");
    DELAY 3 FRAMES
  END
  PRINT "done.";
  
  
  // VIEW has optional arguments similar to RANGE. 
  PRINT "iterating over slice of buffer, viewing values as buffer_f64.";
  FOREACH key, value IN VIEW(buffer, buffer_u32, 10, 20) THEN
    show_debug_message($"buffer_peek(buffer, buffer_f64, {key}) = {value};");
    DELAY 3 FRAMES
  END
  PRINT "done.";
  
  
  // And like RANGE, you can provide iteration parameters as struct.
  PRINT "final iteration, parameters were from struct..";
  FOREACH key, value IN VIEW({
      data: buffer,
      dtype: buffer_f64,
      start: 10,
      stop: 20,
      step: 2,
    }) 
  THEN
    show_debug_message($"buffer_peek(buffer, buffer_f64, {key}) = {value};");
    DELAY 3 FRAMES
  END
  PRINT "done.";
  
  
  FINISH 
DISPATCH 













