

// Handle listeners.
coroutine_async_listen();


// Check whether request exists.
with(COROUTINE_ASYNC_REQUESTS[? async_load[? "id"]])
{
  // Trigger request based on status.
  var _status = async_load[? "status"];
  if (_status == true)
  {
    onSuccess(self);
    Destroy();
    exit;
  }

  // Condition is bugged in HTML5, it returns -1 even though should return false
  // As GML interpretes false as 0, both cases are covered with <= 0
  // https://github.com/YoYoGames/GameMaker-Bugs/issues/261
  if (_status <= 0)
  {
    Failure();
    exit;
  }
}
