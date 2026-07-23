/// @desc HTTP REQUEST.


KORUTIINI BEGIN

  url = "https://httpbin.org/ip";
  data = undefined;
  failed = false;
  
  // Make the request.
  KorutiiniExample_Log($"Making URL request: '{url}'!");
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
      KorutiiniExample_Log($"[{_async.request}] Pending {_progress}");
      
    ON_SUCCESS 
      KorutiiniExample_Log($"[{_async.request}] Success!");
      data = async_load[? "result"];
      
    ON_FAILURE 
      KorutiiniExample_Log($"[{_async.request}] Failure!");
      failed = true;
      
  ASYNC_END
  
  // Await for the result.
  AWAIT_REQUESTS
  
  if (failed)
  {
    KorutiiniExample_Log($"URL '{url}' get did not succeed!");
    EXIT;
  }
  KorutiiniExample_Log($"URL '{url}' has been fetched!");
  KorutiiniExample_Log($"{data}");
  
FINISH DISPATCH 


