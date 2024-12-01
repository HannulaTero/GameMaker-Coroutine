/// @desc SPRITE BROADCAST.

var _w = sprite_get_width(sprite_index);
var _h = sprite_get_height(sprite_index);
x = room_width - _w - 32
y = room_height - _h - 32;
repeat(instance_number(object_index))
{
  if (collision_point(x, y, object_index, false, true))
  {
    x -= _w + 32;
  }
}


COROUTINE BEGIN 
  
  
  ASYNC_LISTENER type: ev_broadcast_message
    ON_LISTEN
      show_debug_message($"broadcast element id: {event_data[? "element_id"]}");
      var _element = event_data[? "element_id"];
      if (layer_get_element_type(_element) != layerelementtype_instance)
        return;
      var _instance = layer_instance_get_instance(_element);
      if (_instance != this.id)
        return;
      coroutine.Set(event_data[? "message"]);
  ASYNC_END
  
  
  LOOP
    AWAIT coroutine.Get() != undefined PASS 
    show_debug_message($"broadcast: {coroutine.Get()}");
    if (coroutine.Get() == "destroy")
    {
      instance_destroy(this);
      EXIT
    }
    SET undefined PASS
  END
  
  
FINISH DISPATCH

