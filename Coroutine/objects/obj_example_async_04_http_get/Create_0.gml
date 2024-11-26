/// @desc HTTP REQUEST.


COROUTINE BEGIN

  url = "https://httpbin.org/ip";
  data = undefined;
  failed = false;
  
  // Make the request.
  ASYNC_REQUEST
    DO_REQUEST 
      return http_get(url);
      
    ON_PENDING 
      var _progress = "";
      var _contentLength = async_load[? "contentLength"];
      var _sizeDownloaded = async_load[? "sizeDownloaded"];
      if (_contentLength != -1)
      {
        _progress = $"{(_contentLength / _sizeDownloaded) * 100.0} %"
      }
      show_debug_message($"[{_async.request}] Pending {_progress}");
      
    ON_SUCCESS 
      show_debug_message($"[{_async.request}] Success!");
      data = async_load[? "result"];
      
    ON_FAILURE 
      show_debug_message($"[{_async.request}] Failure!");
      failed = true;
      
  ASYNC_END
  
  // Await for the result.
  AWAIT_REQUESTS
  if (failed)
  {
    show_debug_message($"URL '{url}' get did not succeed!");
    EXIT;
  }
  show_debug_message($"URL '{url}' has been fetched!");
  show_debug_message($"{data}");
  
  
FINISH DISPATCH 


