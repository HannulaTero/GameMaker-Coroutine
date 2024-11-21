show_debug_overlay(true, false);

var i = 0; 
repeat(1000)
{
  
  instance_create_depth(lerp(0, room_width, i++/1000), random(room_height), 0, obj_example_thing);
}

/*
COROUTINE BEGIN

ASYNC_BEGIN 
  type: ev_async_social,
ON_LISTEN
  show_debug_message(async_load[? "result"]);
ASYNC_END

var _async = new CoroutineAsync({
  type: ev_async_social
}).SetListen(function() {
  show_debug_message(async_load[? "result"] * 10);
}).AsyncDispatch();

/*
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