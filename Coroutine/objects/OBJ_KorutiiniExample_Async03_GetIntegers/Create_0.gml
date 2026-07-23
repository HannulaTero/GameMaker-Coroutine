/// @desc GET INTEGERS.


width = 64;
height = 64;


KORUTIINI BEGIN

  width = this.width;
  height = this.height;
  failed = false;
  
  // Ask for the width.
  ASYNC_REQUEST
    request: get_integer_async("Give me width", width)
    ON_SUCCESS width = async_load[? "value"];
    ON_FAILURE failed = true;
  ASYNC_END
  
  // Ask for the height.
  ASYNC_REQUEST
    request: get_integer_async("Give me height", height)
    ON_SUCCESS height = async_load[? "value"];
    ON_FAILURE failed = true;
  ASYNC_END
  
  // Await both. 
  KorutiiniExample_Log("Waiting for answers.");
  AWAIT_REQUESTS
  
  // Succession test.
  if (failed == true)
  || (is_string(width))
  || (is_string(height))
  {
    KorutiiniExample_Log("Failed to fetch the size.");
    EXIT;
  }
  
  // Set the final values.
  this.width = width;
  this.height = height;
  KorutiiniExample_Log($"Fetched size: [{width}, {height}].");
  
FINISH DISPATCH

