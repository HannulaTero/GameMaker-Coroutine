show_debug_overlay(true, false);

repeat(1_000)
{
  instance_create_depth(random(room_width), random(room_height), 0, obj_example_thing);
}


COROUTINE BEGIN

LOOP
DELAY 500 MILLIS
time = get_timer();
result = 0;
REPEAT 100 THEN
REPEAT 100 THEN
REPEAT 100 THEN
  result += 1;
END
END
END

show_debug_message((get_timer() - time) / 1000);
END
FINISH DISPATCH