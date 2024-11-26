/// @desc BUFFER SAVE.


// Create the buffer.
filename = "buffer.save";
dtype = buffer_f64;
dsize = buffer_sizeof(dtype);
count = 1024 * 1024 * 8;
bytes = count * dsize;
buffer = buffer_create(bytes, buffer_fixed, dsize);


// Fill the contents of the buffer.
// Because it is such big buffer, filling takes some itme.
// So coroutine can be handy here.
taskBufferCreate = COROUTINE BEGIN
  chunk = 1024;
  dtype = this.dtype;
  count = this.count;
  buffer = this.buffer;
  buffer_seek(buffer, buffer_seek_start, 0);
  WHILE count > 0 THEN
    repeat(min(count, chunk))
    {
      buffer_write(buffer, dtype, random(1.0));
    }
    count -= chunk;
  END
FINISH DISPATCH 


// For saving buffer asynchronously.
COROUTINE BEGIN

  // Wait until buffer contents have been filled.
  AWAIT this.taskBufferCreate.isFinished() PASS
  
  // Make the request.
  request = ASYNC_REQUEST
    DO_REQUEST return buffer_save_async(this.buffer, this.filename, 0, this.bytes);
    ON_SUCCESS show_debug_message($"[{_async.request}] Success!");
    ON_FAILURE show_debug_message($"[{_async.request}] Failure!");
  ASYNC_END
  
  // Await for the result.
  AWAIT_REQUESTS
  if (request.hasFailed())
  {
    show_debug_message($"Saving buffer has failed!");
    EXIT;
  }
  show_debug_message($"Buffer has been saved!");
  
FINISH DISPATCH






