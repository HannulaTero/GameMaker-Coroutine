/// @desc SELECT GROUP & EXAMPLE

if (keyboard_check(vk_anykey) == false)
  exit;


if (keyboard_check_pressed(vk_enter))
{
  instance_destroy(obj_example_base);
  instance_create_depth(0, 0, 0, exampleActive);
  exit;
}


// Get cursor movement..
var _xdir = sign(
  - keyboard_check_pressed(vk_left)
  + keyboard_check_pressed(vk_right)
);

var _ydir = sign(
  - keyboard_check_pressed(vk_up)
  + keyboard_check_pressed(vk_down)
);


// Select group index.
groupIndex += _xdir;

if (groupIndex < 0) 
  groupIndex = groupCount - 1;
  
if (groupIndex >= groupCount) 
  groupIndex = 0;
  
groupName = groupNames[groupIndex];
  
  
// Select example.
var _exampleIndex = groupExampleIndex[$ groupName];
var _exampleCount = array_length(examples[$ groupName]);
_exampleIndex += _ydir;

if (_exampleIndex < 0) 
  _exampleIndex = _exampleCount - 1;
  
if (_exampleIndex >= _exampleCount) 
  _exampleIndex = 0;
  
  
// Update the example.
groupExampleIndex[$ groupName] = _exampleIndex;
exampleIndex = _exampleIndex;
exampleActive = examples[$ groupName][_exampleIndex];
exampleName = object_get_name(exampleActive);


