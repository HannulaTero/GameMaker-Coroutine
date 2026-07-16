

// Handle listeners.
__Coroutine_AsyncListen();


// Check whether request exists.
with(COROUTINE_ASYNC_REQUESTS[? async_load[? "sound_id"]])
{
  onSuccess(self);
  Destroy();
}
