/// @desc BUFFER LOAD.


// Create the buffer.
filename = "buffer.save";
dtype = buffer_f64;
dsize = buffer_sizeof(dtype);
count = 1;
bytes = count * dsize;
buffer = buffer_create(bytes, buffer_grow, dsize);


// Coroutine action for loading buffer.
KORUTIINI BEGIN
  
  // Make the request.
  request = ASYNC_REQUEST
    DO_REQUEST 
      return buffer_load_async(this.buffer, this.filename, 0, -1);
      
    ON_SUCCESS 
      KorutiiniExample_Log($"[{_async.request}] Success!");
      this.bytes = buffer_get_size(this.buffer);
      this.count = this.bytes / this.dsize;
      
    ON_FAILURE 
      KorutiiniExample_Log($"[{_async.request}] Failure!");
      
  ASYNC_END
  
  // Await for the result.
  AWAIT_REQUESTS
  if (request.HasFailed())
  {
    KorutiiniExample_Log($"Loading buffer has failed!");
    EXIT;
  }
  KorutiiniExample_Log($"Buffer has been loaded!");
  
FINISH DISPATCH
