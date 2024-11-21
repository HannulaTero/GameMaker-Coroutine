
var _index = 0;
repeat(100)
{
  var _map = ds_map_create();
  _map[? "result"] = _index++;
  event_perform_async(ev_async_social, _map);
}
