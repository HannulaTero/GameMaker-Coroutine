show_debug_overlay(true, true);


array = array_create_ext(30, function()
{
  return random(1);
});


coroutine = COROUTINE BEGIN

  DELAY 3_000 MICROS
  FOREACH key, value IN [10, 20, 30, 40] THEN
    show_debug_message($"{key}: {value}");
    DELAY 0.1 SECONDS
  END
  
  
  REPEAT 1 THEN
    result = 0;
    SWITCH irandom(11) 
      CASE 0 THEN result += 0;
      CASE 1 THEN result += 1;
      CASE 2 THEN result += 2;
      CASE 3 THEN result += 3;
      CASE 4 THEN result += 4;
      CASE 5 THEN result += 5;
      CASE 6 THEN result += 6;
      CASE 7 THEN result += 7;
      CASE 8 THEN result += 8;
      CASE 9 THEN result += 9;
    END
    show_debug_message(result);
  END
  
  
  index = 0; 
  DO show_debug_message("HEY 1"); UNTIL true END
  DO show_debug_message("HEY 2"); index--; UNTIL index <= 0 END
  index = 3; 
  DO show_debug_message("HEY 3"); index--; UNTIL index <= 0 END

  
FINISH DISPATCH

surface = -1;

coroutine = COROUTINE
    name: @'Drawing Coroutine',
    desc: @'This coroutine is testing triggers and drawing.',
    slot: 1.0,
  
  ON_INIT
    x = mouse_x;
    y = mouse_y;
  
  ON_LAUNCH
    if (!surface_exists(this.surface))
    {
      this.surface = surface_create(room_width, room_height);
    }
    surface_set_target(this.surface);

  ON_YIELD
    surface_reset_target();

  BEGIN
    LOOP
      if (device_mouse_check_button(0, mb_left))
      {
        draw_line(x, y, mouse_x, mouse_y);
      }
      x = mouse_x;
      y = mouse_y;
      
      YIELD "Drawing" PASS
    END
  FINISH 
  
DISPATCH


COROUTINE BEGIN

  i = 1;
  REPEAT 10 THEN
    YIELD i PASS
    i *= 2
    show_debug_message(i);
  END

FINISH DISPATCH 


// Create a coroutine.
COROUTINE BEGIN

  // Coroutine scoped variables.
  url = "https://www.google.com";
  data = undefined;
  
  // Make HTTP request.
  request = ASYNC_BEGIN
      type: "http",
      desc: $"Request for http_get({url})",
      timeout: 3.0,
  
    GET_REQUEST
      return http_get(url);
    
    ON_SUCCESS
      data = async_load[? "result"];  
      show_debug_message($"HTTP GET for \"{url}\" successful");
      
    ON_FAILURE
      show_debug_message($"HTTP GET for \"{url}\" unsuccessful");
    
    ON_TIMEOUT
      show_debug_message($"HTTP GET for \"{url}\" timed out");
  
  ASYNC_END
  
  // Await until request is done.
  AWAIT request.isFinished() PASS
  
  show_debug_message($"data = \"{data}\"");
  show_debug_message($"HTTP GET for \"{url}\" complete");
        

  // Do a for-loop just because.
  LABEL "restart" PASS
  
  FOR i = 0;
  COND i < 100;
  ITER i++;
  THEN
    show_debug_message(i);
    if (keyboard_check_pressed(vk_enter)) QUIT;
    if (keyboard_check_pressed(vk_space)) GOTO "restart";
    YIELD "Looping" PASS
  END

// End coroutine, then dispatch it.
FINISH DISPATCH






COROUTINE BEGIN

  // Dispatch subcoroutine.
  COROUTINE BEGIN
    DELAY random_range(2.0, 5.0) SECONDS
    show_debug_message("First child-coroutine");
  FINISH DISPATCH 

  // Dispatch subcoroutine.
  COROUTINE BEGIN
    DELAY random_range(2.0, 5.0) SECONDS
    show_debug_message("Second child-coroutine");
  FINISH DISPATCH 

  // Dispatch subcoroutine.
  COROUTINE BEGIN
    DELAY random_range(2.0, 5.0) SECONDS
    show_debug_message("Third child-coroutine");
  FINISH DISPATCH 

  // Await all subcoroutines to be finished.
  AWAIT_CHILDRENS
  show_debug_message("Parent coroutine");  
  

FINISH DISPATCH 
  
  
  
  
COROUTINE BEGIN
  
  FOREACH i: key, ival: value IN RANGE(0, 1024, +16) THEN
  FOREACH j: key, jval: value IN RANGE(0, 1024, +32) THEN
  FOREACH k: key, kval: value IN RANGE(1024, 0, -10) THEN
  FOREACH l: key, lval: value IN RANGE(1024, 0, -20) THEN
    show_debug_message($"[{i}][{j}][{k}][{l}] = [{ival}][{jval}][{kval}][{lval}]");
    DELAY 1.0 SECONDS
  END END END END
    
FINISH DISPATCH 















