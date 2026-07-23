

// Handle listeners.
__Korutiini_AsyncListen();


// Check whether request exists.
with(asyncRequests[? async_load[? "queue_id"]])
{
  onSuccess(self);
  Destroy();
}


