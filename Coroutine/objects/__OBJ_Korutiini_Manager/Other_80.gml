

// Handle listeners.
__Korutiini_AsyncListen();


// Check whether request exists.
with(asyncRequests[? async_load[? "sound_id"]])
{
  onSuccess(self);
  Destroy();
}
