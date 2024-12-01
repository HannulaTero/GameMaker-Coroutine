/// @desc VISUALIZE SURFACE.

var _surf = task.scope.surface;
if (surface_exists(_surf))
{
  draw_surface_stretched(_surf, x, y, image_xscale, image_yscale);
}
else
{
  draw_self();
}

draw_set_font(ft_example);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
var _x = x + image_xscale * 0.5; 
var _y = y + image_yscale * 0.5; 
draw_text(_x, _y, task.Get() ?? "Please wait...");
