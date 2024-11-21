
draw_sprite_ext(spr_example_thing, 0, room_width - 64, room_height - 64, 1, 1, current_time, c_white, 1);

var _active = ds_map_size(COROUTINE_POOL_ACTIVE);
var _paused = ds_map_size(COROUTINE_POOL_PAUSED);
draw_text(32, 256, $"active : {_active}");
draw_text(32, 288, $"paused : {_paused}");
draw_text(32, 320, $"all    : {_active + _paused}");

