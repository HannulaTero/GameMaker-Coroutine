

var _surf = task.scope.surface;
if (surface_exists(_surf))
{
  var _w = 512;
  var _h = 512;
  var _x = room_width - _w - 32
  var _y = room_height - _h - 32;
  draw_surface_stretched(_surf, _x, _y, _w, _h);
}