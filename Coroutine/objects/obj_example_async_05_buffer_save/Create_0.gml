/// @desc BUFFER SAVE.


// Create the buffer.
filename = "buffer.save";
dtype = buffer_f64;
dsize = buffer_sizeof(dtype);
count = 1024 * 1024 * 8;
chunk = 16;
bytes = count * dsize;
buffer = buffer_create(bytes, buffer_fixed, dsize);


// Fill the contents of the buffer with random data.
// Because it is such big buffer, filling takes some time, but coroutine splits the task to several frames. 
// But because of performance penalty from coroutines, it is good to do in chunks.
taskBufferCreate = COROUTINE scoped: false 
BEGIN
  show_debug_message("Start generating buffer data.");
  buffer_seek(buffer, buffer_seek_start, 0);
  WHILE count > 0 THEN
    repeat(min(count, chunk))
    {
      buffer_write(buffer, dtype, random(1.0));
    }
    count -= chunk;
  END
  show_debug_message("Buffer filled.");
FINISH DISPATCH 


// For saving buffer asynchronously.
COROUTINE BEGIN

  // Wait until buffer contents have been filled.
  AWAIT this.taskBufferCreate.isFinished() PASS
  
  // Make the request.
  show_debug_message("Started saving the buffer.");
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






