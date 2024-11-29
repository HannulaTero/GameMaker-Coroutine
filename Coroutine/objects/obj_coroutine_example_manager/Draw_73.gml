/// @desc DRAW INFORMATION.

// Draw FPS
{
  fpsSum += fps_real;
  var i = 0;
  var _x = 16;
  var _y = 128;
  draw_set_font(ft_example);
  draw_set_halign(fa_left);
  draw_set_valign(fa_top);
  draw_set_alpha(0.5);
  draw_text(16, _y + 24 * i++, $"fps real : {fps_real}");
  draw_text(16, _y + 24 * i++, $"fps avg  : {fpsAvg}");
  draw_set_alpha(1.0);
}



// Draw the counts.
{
  var i = 0;
  var _x = 16;
  var _y = room_height - 96;
  var _active = ds_map_size(COROUTINE_POOL_ACTIVE);
  var _paused = ds_map_size(COROUTINE_POOL_PAUSED);
  var _delayed = ds_map_size(COROUTINE_POOL_DELAYED);

  draw_set_font(ft_example);
  draw_set_halign(fa_left);
  draw_set_valign(fa_bottom);
  draw_set_alpha(0.5);
  draw_text(16, _y + 24 * i++, $"active  : {_active}");
  draw_text(16, _y + 24 * i++, $"paused  : {_paused}");
  draw_text(16, _y + 24 * i++, $"delayed : {_delayed}");
  draw_text(16, _y + 24 * i++, $"all     : {_active + _paused + _delayed}");
  draw_set_alpha(1.0);
}


// Spinner to show some activity.
{
  var _x = room_width - 32;
  var _y = room_height - 32;
  var _r = current_time;
  var _c = make_color_hsv(0, 0, 240);
  draw_sprite_ext(spr_example_thing, 0, _x, _y, 0.5, 0.5, _r, _c, 0.5);
}


