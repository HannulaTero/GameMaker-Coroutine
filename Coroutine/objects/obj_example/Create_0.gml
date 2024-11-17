


array = array_create_ext(1000, function()
{
  return random(1);
});


coroutine = COROUTINE BEGIN

  DELAY 3_000 MICROS
  FOREACH key, value IN this.array THEN
    show_debug_message($"{key}: {value}");
    DELAY 0.1 SECONDS
  END
  
FINISH DISPATCH


surface = -1;

drawing = COROUTINE
    name: @'Drawing Coroutine',
    desc: @'This coroutine is testing triggers and drawing.',
    slot : 1.0,

  ON_LAUNCH
    if (!surface_exists(this.surface))
      this.surface = surface_create(room_width, room_height);
    surface_set_target(this.surface);

  ON_YIELD
    surface_reset_target();

  BEGIN
    x = mouse_x;
    y = mouse_y;
    LOOP THEN
      if (device_mouse_check_button(0, mb_left))
        draw_line(x, y, mouse_x, mouse_y);
      AWAIT (!device_mouse_check_button(0, mb_right)) PASS
      x = mouse_x;
      y = mouse_y;
      YIELD "Drawing" PASS
    END
  FINISH 
  
DISPATCH




