

// Handle listeners.
coroutine_async_listen();


// Check whether request exists.
var _id = async_load[? "id"];
var _request = COROUTINE_ASYNC_REQUESTS[? event_number][? _id];
if (_request == undefined)
{
  exit;
}


// Trigger request based on status.
var _status = async_load[? "status"];
if (_status == true)
{
  _request.onSuccess();
  _request.Remove();
  exit;
}

if (_status == false)
{
  _request.onFailure();
  _request.Remove();
  exit;
}
