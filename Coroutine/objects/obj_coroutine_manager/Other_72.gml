

// Check whether request exists.
var _id = async_load[? "id"];
var _request = __COROUTINE_ASYNC_REQUESTS[? "save/load"][? _id];
if (_request == undefined)
{
  exit;
}


// Trigger request based on status.
var _status = async_load[? "status"];
if (_status == true)
{
  _request.onSuccess();
  _request.SetFinished();
  exit;
}

if (_status == false)
{
  _request.onFailure();
  _request.SetFinished();
  exit;
}
