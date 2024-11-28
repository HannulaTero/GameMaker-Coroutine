/// @desc SELECT GROUP & EXAMPLE

if (keyboard_check(vk_anykey) == false)
  exit;


if (keyboard_check_pressed(vk_enter))
{
  instance_destroy(obj_example_base);
  instance_create_depth(0, 0, 0, groups[index].Get());
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
  


