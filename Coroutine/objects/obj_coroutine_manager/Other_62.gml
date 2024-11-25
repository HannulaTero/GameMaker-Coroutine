

// Handle listeners.
coroutine_async_listen();


// Check whether request exists.
with(COROUTINE_ASYNC_REQUESTS[? async_load[? "id"]])
{
  // Trigger request based on status.
  var _status = async_load[? "status"];
  if (_status == 0)
  {
    onSuccess(self);
    Destroy();
    exit;
  }

  if (_status < 0)
  {
    onFailure(self);
    Destroy();
    exit;
  }

  if (_status > 0)
  {
    onWaiting(self);
    exit;
  }
}
