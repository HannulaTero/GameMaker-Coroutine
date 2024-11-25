

// Handle listeners.
coroutine_async_listen();


// Check whether request exists.
with(COROUTINE_ASYNC_REQUESTS[? async_load[? "queue_id"]])
{
  onSuccess(self);
  Destroy();
}


