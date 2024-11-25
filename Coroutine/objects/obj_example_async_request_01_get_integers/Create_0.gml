/// @desc CREATE COROUTINE PROTOTYPE.


width = 64;
height = 64;


requestSize = COROUTINE BEGIN

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
  show_debug_message("Waiting for answers.");
  AWAIT_REQUESTS
  
  // Succession test.
  if (failed == true)
  || (is_string(width))
  || (is_string(height))
  {
    show_debug_message("Failed to fetch the size.");
    EXIT;
  }
  
  // Set the final values.
  this.width = width;
  this.height = height;
  show_debug_message($"Fetched size: [{width}, {height}].");
  
FINISH 


