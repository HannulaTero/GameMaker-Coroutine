

draw_set_font(ft_example);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

var _c = c_white
var _xGroup = xstart - groupIndex * 256;
var _yGroup = ystart;
x = lerp(x, _xGroup, 0.25);
y = lerp(y, _yGroup, 0.25);

draw_sprite_ext(spr_example_plate, 0, xstart, ystart, 6, 1, 0, c_white, 0.1);
for(var i = 0; i < groupCount; i++)
{  
  _xGroup = x + i * 256;
  _yGroup = y;
  
  var _groupName = groupNames[i];
  var _examples = examples[$ _groupName];
  var _countExamples = array_length(_examples);
  var _exampleIndex = groupExampleIndex[$ _groupName];
  
  for(var j = 0; j < _countExamples; j++)
  {
    var _xExample = 0.0;
    var _yExample = (j - _exampleIndex) * 32;
    
    var _a = 1.0;
    _a *= (i == groupIndex) ? 1.0 : 0.5;
    _a *= (1.0 - (j != _exampleIndex) * 0.5 - 0.0625 * abs(j - _exampleIndex));
    var _x = _xGroup + _xExample;
    var _y = _yGroup + _yExample;
    var _name = object_get_name(_examples[j]);
    _name = string_replace(_name, $"obj_example_{_groupName}_", "");
    _name = string_copy(_name, 4, string_length(_name) - 3);
    draw_text_color(_x, _y, _name, _c, _c, _c, _c, _a);
  }
  
  var _x = _xGroup;
  var _y = _yGroup - 112;
  draw_sprite_ext(spr_example_plate, 0, _x, _y, 6, 1, 0, c_black, 0.6);
  draw_text_color(_x, _y, string_upper(_groupName), _c, _c, _c, _c, 1.0);
}






