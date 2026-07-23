/// @desc BUFFER SAVE.


// Create the buffer.
filename = "buffer.save";
dtype = buffer_f64;
dsize = buffer_sizeof(dtype);
count = 1024 * 1024 * 8;
chunk = 1024;
bytes = count * dsize;
buffer = buffer_create(bytes, buffer_fixed, dsize);


// Fill the contents of the buffer with random data.
// Because it is such big buffer, filling takes some time, but coroutine splits the task to several frames. 
// But because of performance penalty from coroutines, it is good to do in chunks.
taskBufferCreate = KORUTIINI scoped: false 
BEGIN
  KorutiiniExample_Log("Start generating buffer data.");
  buffer_seek(buffer, buffer_seek_start, 0);
  WHILE count > 0 THEN
    repeat(min(count, chunk))
    {
      buffer_write(buffer, dtype, random(1.0));
    }
    count -= chunk;
  END
  KorutiiniExample_Log("Buffer filled.");
FINISH DISPATCH 


// For saving buffer asynchronously.
KORUTIINI BEGIN

  // Wait until buffer contents have been filled.
  AWAIT this.taskBufferCreate.IsFinished() PASS
  
  // Make the request.
  KorutiiniExample_Log("Started saving the buffer.");
  request = ASYNC_REQUEST
    DO_REQUEST return buffer_save_async(this.buffer, this.filename, 0, this.bytes);
    ON_SUCCESS KorutiiniExample_Log($"[{_async.request}] Success!");
    ON_FAILURE KorutiiniExample_Log($"[{_async.request}] Failure!");
  ASYNC_END
  
  // Await for the result.
  AWAIT_REQUESTS
  if (request.HasFailed())
  {
    KorutiiniExample_Log($"Saving buffer has failed!");
    EXIT;
  }
  KorutiiniExample_Log($"Buffer has been saved!");
  
FINISH DISPATCH






