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

  QUIT

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
  
  buffer = buffer_create(1024, 4, 4);
  FOREACH key, value IN VIEW({ data: buffer, dtype: buffer_f32 }) THEN
  
  END
  
  
  LOOP
    SWITCH random(10) 
      CASE 0 THEN show_debug_message("0");
      CASE 1 THEN show_debug_message("1");
      CASE 2 THEN show_debug_message("2");
      CASE 3 THEN show_debug_message("3");
      CASE 4 THEN show_debug_message("4");
      CASE 5 THEN show_debug_message("5");
      CASE 6 THEN show_debug_message("6");
      CASE 7 THEN show_debug_message("7");
      CASE 8 THEN show_debug_message("8");
      CASE 9 THEN show_debug_message("9");
      DEFAULT BREAK
    END
  END
  
  SWITCH choose(0, 1)
  END
  
  SWITCH choose(0, 1)
  CASE 0 THEN
  END
  
  SWITCH choose(0, 1)
  DEFAULT
  END
  
  
  FOREACH i: key, ival: value IN RANGE(0, 1024, +16) THEN
  FOREACH j: key, jval: value IN RANGE(0, 1024, +32) THEN
  FOREACH k: key, kval: value IN RANGE(1024, 0, -10) THEN
  FOREACH l: key, lval: value IN RANGE(1024, 0, -20) THEN
    show_debug_message($"[{i}][{j}][{k}][{l}] = [{ival}][{jval}][{kval}][{lval}]");
  END END END END
    
FINISH DISPATCH 















