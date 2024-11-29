show_debug_overlay(true, true);

surface = -1;



coroutine = COROUTINE BEGIN

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
  AWAIT_SUBTASKS
  show_debug_message("Parent coroutine");  
  

FINISH DISPATCH 



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
  
  
  REPEAT 10 THEN
    result = 0;
    SWITCH irandom(11) 
      CASE 0 THEN result += random_range(0, 10); YIELD_SET "case 0 yielded" PASS
      CASE 1 THEN result += random_range(1, 10); PAUSE_SET "case 1 paused" PASS
      CASE 2 THEN result += random_range(2, 10); DELAY 100 MILLIS
      CASE 3 THEN result += random_range(3, 10); GOTO "label case 7";
      CASE 4 THEN result += random_range(4, 10); CONTINUE
      CASE 5 THEN result += random_range(5, 10); RETURN "return value";
      CASE 6 THEN result += random_range(6, 10); 
      CASE 7 THEN result += random_range(7, 10); LABEL "label case 7" 
      CASE 8 THEN result += random_range(8, 10); BREAK
      CASE 9 THEN result += random_range(9, 10); YIELD_SET "case 9 yielded" PASS
    END
    DELAY 100 MILLIS
    show_debug_message(result);
  END
  
  
  index = 0; 
  DO show_debug_message("HEY 1"); UNTIL true END
  DO show_debug_message("HEY 2"); index--; UNTIL index <= 0 END
  index = 3; 
  DO show_debug_message("HEY 3"); index--; UNTIL index <= 0 END

  
FINISH DISPATCH



coroutine = COROUTINE BEGIN

  LABEL "loop" PASS
  IF choose(true, false) THEN
    YIELD_SET "let other coroutines do their thing" PASS
    
  ELIF choose(true, false) THEN
    AWAIT (mouse_x > 100) PASS
  
  ELSE
    DELAY 100 MILLIS
  
  END
  GOTO "loop"


FINISH DISPATCH



coroutine = coroutine_create(function() 
{ 
  return { 
  // DEFINE OPTIONS & TRIGGERS.
  define: ({ 
    option: ({ 
    })
  }), 
  
  // EXECUTABLE DATA.
  graph: {}, 
  tables: [], 
  labels: {}, 
    
  // GENERATE AST.
  nodes: CO_BLOCK([
    CO_STMT(function() { }), 
        
    // LABEL
    CO_LABEL({ label: "loop" }), 
    CO_STMT(function() { }), 
        
    // IF-STATEMENT
    CO_IF_CHAIN(
      
      // THEN
      (function() { return choose(true, false) }), 
      CO_BLOCK([
        CO_STMT(function() { }), 
        CO_YIELD(),  
        CO_STMT(function() { })
      ]), 
        
      // ELIF
      (function() { return choose(true, false) }), 
      CO_BLOCK([
        CO_STMT(function() { }), 
        CO_AWAIT("COND", function() { return (mouse_x > 100) }), 
        CO_STMT(function() { })
      ]), 
    
      // ELSE
      (CO_NOP), 
      CO_BLOCK([
        CO_STMT(function() { }), 
        CO_DELAY(function() { return 100 }, "MILLIS"), 
        CO_STMT(function() { })
      ])
      
    ),
      
    // GOTO STATEMENT.
    CO_STMT(function() {
        
      for(var ____;; { 
        return CO_RUNTIME_GOTO(____); 
      }) ____ = "loop"
        
    }), 
      
    // FINISH
    CO_FINISH()
  ])}; 

// DISPATCH
}).Dispatch(self)



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
    camera_apply(camera_get_active());
    draw_surface(this.surface, 0, 0);

  BEGIN
    LOOP
      if (device_mouse_check_button(0, mb_left))
      {
        draw_line(x, y, mouse_x, mouse_y);
      }
      x = mouse_x;
      y = mouse_y;
      
      YIELD_SET "Drawing" PASS
    END
  FINISH 
  
DISPATCH


COROUTINE BEGIN

  i = 1;
  REPEAT 10 THEN
    YIELD_SET i PASS
    i *= 2
    show_debug_message(i);
  END

FINISH DISPATCH 


// Create a coroutine.
COROUTINE BEGIN

  // Coroutine scoped variables.
  url = "https://www.google.fi/";
  data = undefined;
  
  // Make HTTP request.
  request = ASYNC_REQUEST
      name: "HTTP Get",
      desc: $"Request for http_get({url})",
      timeout: 5.0,
      retries: 3
  
    DO_REQUEST
      return http_get(url);
    
    ON_SUCCESS
      data = async_load[? "result"];  
      show_debug_message($"HTTP GET for \"{url}\" successful!");
      
    ON_FAILURE
      show_debug_message($"HTTP GET for \"{url}\" unsuccessful!");
    
    ON_TIMEOUT
      show_debug_message($"HTTP GET for \"{url}\" timed out!");
  
  ASYNC_END
  
  
  ASYNC_LISTENER 
    type: ev_async_web
  
    ON_LISTEN 
    
  ASYNC_END
  
  // Await until request is done.
  AWAIT request.isFinished() PASS
  
  show_debug_message($"data = \"{data}\"");
  show_debug_message($"HTTP GET for \"{url}\" complete!");
        

  // Do a for-loop just because.
  LABEL "restart" PASS
  
  FOR i = 0;
  COND i < 100;
  ITER i++;
  THEN
    show_debug_message(i);
    if (keyboard_check_pressed(vk_enter)) EXIT;
    if (keyboard_check_pressed(vk_space)) GOTO "restart";
    YIELD_SET "Looping" PASS
  END

// End coroutine, then dispatch it.
FINISH DISPATCH





  
  
  
  
coroutine_foreach = COROUTINE BEGIN
  
  FOREACH i: key, ival: value IN RANGE(0, 1024, +16) THEN
  FOREACH j: key, jval: value IN RANGE(0, 1024, +32) THEN
  FOREACH k: key, kval: value IN RANGE(1024, 0, -10) THEN
  FOREACH l: key, lval: value IN RANGE(1024, 0, -20) THEN
    show_debug_message($"[{i}][{j}][{k}][{l}] = [{ival}][{jval}][{kval}][{lval}]");
    if (keyboard_check(ord("1"))) CONTINUE
    if (keyboard_check(ord("2"))) BREAK
    if (keyboard_check(ord("3"))) EXIT
    if (keyboard_check(ord("5"))) RETURN 100;
    
    // Using macro syntax is okay.
    IF choose(true, false) THEN
    
      IF choose(true, false) THEN
        show_debug_message("Awaiting!")
        AWAIT choose(true, false) PASS
        show_debug_message("Awaited!")
      
      ELIF choose(true, false) THEN
        show_debug_message("Yielding!")
        YIELD_SET "yielded!" PASS
        show_debug_message("Hoy!")
      
      ELIF choose(true, false) THEN
        show_debug_message("Pausing!")
        PAUSE_SET "paused!" PASS
        show_debug_message("Pause resumed!")
      
      ELSE 
        show_debug_message("Starting delay!")
        DELAY 100 FRAMES
        show_debug_message("Delay passes!")
      
      END
    END
    
    
    
    DELAY 0.1 SECONDS
  END END END END
    
FINISH DISPATCH 















