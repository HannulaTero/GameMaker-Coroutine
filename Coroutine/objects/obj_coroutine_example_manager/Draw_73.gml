/// @desc DRAW COROUTINE COUNTS.


var _x = room_width - 64;
var _y = room_height - 64;
var _c = make_color_hsv(0, 0, 240);
draw_sprite_ext(spr_example_thing, 0, _x, _y, 1, 1, current_time, _c, 1);

var _active = ds_map_size(COROUTINE_POOL_ACTIVE);
var _paused = ds_map_size(COROUTINE_POOL_PAUSED);
var _delayed = ds_map_size(COROUTINE_POOL_DELAYED);
var i = 0;
draw_text(32, 256 + 32 * i++, $"active  : {_active}");
draw_text(32, 256 + 32 * i++, $"paused  : {_paused}");
draw_text(32, 256 + 32 * i++, $"delayed : {_delayed}");
draw_text(32, 256 + 32 * i++, $"all     : {_active + _paused + _delayed}");