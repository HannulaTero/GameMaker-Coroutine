/// @desc BUFFER LOAD.


// Create the buffer.
filename = "buffer.save";
dtype = buffer_f64;
dsize = buffer_sizeof(dtype);
count = 1;
bytes = count * dsize;
buffer = buffer_create(bytes, buffer_grow, dsize);


// Coroutine action for loading buffer.
COROUTINE BEGIN
  
  // Make the request.
  request = ASYNC_REQUEST
    DO_REQUEST 
      return buffer_load_async(this.buffer, this.filename, 0, -1);
      
    ON_SUCCESS 
      show_debug_message($"[{_async.request}] Success!");
      this.bytes = buffer_get_size(this.buffer);
      this.count = this.bytes / this.dsize;
      
    ON_FAILURE 
      show_debug_message($"[{_async.request}] Failure!");
      
  ASYNC_END
  
  // Await for the result.
  AWAIT_REQUESTS
  if (request.hasFailed())
  {
    show_debug_message($"Loading buffer has failed!");
    EXIT;
  }
  show_debug_message($"Buffer has been loaded!");
  
FINISH DISPATCH
