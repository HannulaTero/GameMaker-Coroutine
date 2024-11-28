

// Handle listeners.
coroutine_async_listen();


// Check whether request exists.
with(COROUTINE_ASYNC_REQUESTS[? async_load[? "id"]])
{
  // Trigger request based on status.
  var _status = async_load[? "status"];
  
  // Action for all other.
  if (os_browser == browser_not_a_browser)
  {
    if (_status == true)
    {
      onSuccess(self);
      Destroy();
      exit;
    }

    if (_status == false)
    {
      Failure();
      exit;
    }
  }
  // But for HTML5, it's different story.
  else
  {
    switch(_status)
    {
      case 200: 
        onSuccess(self);
        Destroy();
        break;
      case 404:
        Failure();
        break;
      default:
        show_debug_message($"Async Save/Load request[{_request}]: Unknown status '{_status}'");
        break;
    }
  }
}
