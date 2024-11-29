/// @desc A LOT OF INSTANCES.


// Just spawns a lot of instances of same kind.
repeat(1000)
{
  instance_create_depth(random(room_width), random(room_height), 0, obj_example_shaky);
}