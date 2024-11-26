

draw_set_font(ft_example);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

var _c = c_white;
var _xGroup = room_width * 0.50 - groupIndex * 256;
var _yGroup = room_height * 0.40;
x = lerp(x, _xGroup, 0.25);
y = lerp(y, _yGroup, 0.25);

array_foreach(groupNames, function(groupName, i)
{
  with { groupName, i } array_foreach(examples[$ groupName], function(example, j)
  {
    var _x = i;
    var _y = j - exampleIndex;
    var _alpha = (i == groupIndex) ? 1.0 : 0.5 - 0.0625 * abs(j - exampleIndex);
    var _str = object_get_name(example);
    _str = string_replace(_str, $"obj_example_{groupName}_", "");
    _str = string_copy(_str, 4, string_length(_str) - 3);
    
    draw_set_alpha(_alpha);
    draw_text_color(_x, _y, _str);
  });
});
draw_set_alpha(1.0);


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
  
  draw_text_color(_xGroup, _yGroup - 128, string_upper(_groupName), _c, _c, _c, _c, 1);
}






