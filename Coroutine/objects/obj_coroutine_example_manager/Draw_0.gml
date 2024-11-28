/// @desc DRAW LIST OF EXAMPLES.


// Animated movement.
x = lerp(x, xstart - index * 240, 0.25);
y = lerp(y, ystart, 0.25);


// Draw settings.
draw_set_font(ft_example);
draw_set_halign(fa_left);
draw_set_valign(fa_middle);


// Selection backplate.
draw_sprite_ext(spr_example_plate, 0, xstart, ystart, 2, 1, 0, c_white, 0.125);


// Draw all examples!
var _w = 240;
var _h = 32;
for(var i = 0; i < count; i++)
{
  // Draw group name.
  var _group = groups[i];
  var _x = x + _w * i;
  var _y = y - _h * 2;
  draw_set_alpha(1.0);
  draw_sprite_ext(spr_example_plate, 0, _x, _y, 2, 1, 0, c_black, 0.5);
  draw_text(_x, _y, _group.name);
  
  // Draw the examples.
  var _prefix = $"obj_example_{_group.name}_";
  var _examples = groups[i].examples;
  var _exampleCount = array_length(_examples);
  for(var j = 0; j < _exampleCount; j++)
  {
    // Draw position.
    _y = y + _h * (j - _group.index);
    if (_y < y - _h)
      continue;
    
    // Highlight selected.
    var _alpha = 1.0;
    _alpha *= (i == index) ? 1.0 : 0.25;
    _alpha *= (j == _group.index) ? 1.0 : 0.25;
    
    // Remove prefix.
    var _str = object_get_name(_examples[j]);
    _str = string_replace(_str, _prefix, "");
    
    // Draw the text.
    draw_set_alpha(_alpha);
    draw_text(_x, _y, _str);
  }
}

draw_set_alpha(1.0);


