/// @desc SELECT GROUP & EXAMPLE

if (keyboard_check(vk_anykey) == false)
{
  exit;
}


if (keyboard_check_pressed(vk_enter))
{
  var _example = groups[index].Get();
  var _exampleName = object_get_name(_example);
  _exampleName = string_replace(_exampleName ,"OBJ_KorutiiniExample_", "");
  self.Log($"---");
  self.Log($"Launching example : {_exampleName}");
  instance_create_depth(0, 0, 0, _example);
  exit;
}


// Get cursor movement.
var _xdir = sign(
  - keyboard_check_pressed(vk_left)
  + keyboard_check_pressed(vk_right)
);

var _ydir = sign(
  - keyboard_check_pressed(vk_up)
  + keyboard_check_pressed(vk_down)
);


// Select group.
index = clamp(index + _xdir, 0, count - 1);

  
// Select example.
var _group = groups[index];
var _count = array_length(_group.examples);
_group.index = clamp(_group.index + _ydir, 0, _count - 1);
example = _group.Get();
  


