

// Check whether request exists.
var _id = async_load[? "id"];
var _request = COROUTINE_ASYNC_REQUESTS[? event_number][? _id];
if (_request == undefined)
{
  exit;
}


// Trigger request based on status.
var _status = async_load[? "status"];
if (_status >= 0)
{
  _request.onSuccess();
  _request.SetFinished();
  exit;
}

if (_status < 0)
{
  _request.onFailure();
  _request.SetFinished();
  exit;
}
