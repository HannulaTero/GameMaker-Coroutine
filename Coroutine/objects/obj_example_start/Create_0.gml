show_debug_overlay(true, false);

var _count = 1000;
for(var i = 0; i < _count; i++)
{
  var _rate = (i + 0.5) / _count;
  var _x = lerp(0, room_width, _rate);
  var _y = lerp(0, room_height, random(1));
  instance_create_layer(_x, _y, "Instances", obj_example_thing);
}


COROUTINE BEGIN

  ASYNC_LISTENER type: ev_async_web
    ON_LISTEN
      show_debug_message(async_load[? "result"]);
  ASYNC_END


  LOOP
    DELAY 500 MILLIS 
    time = get_timer();
    result = 0;
    REPEAT 100 THEN
    REPEAT 100 THEN
    REPEAT 100 THEN
      result += 1;
    END END END
    show_debug_message((get_timer() - time) / 1000);
  END
  
FINISH DISPATCH