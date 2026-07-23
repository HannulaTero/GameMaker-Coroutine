

// Handle listeners.
__Korutiini_AsyncListen();


// Check whether request exists.
with(asyncRequests[? async_load[? "channel_index"]])
{
  onSuccess(self);
  Destroy();
}

