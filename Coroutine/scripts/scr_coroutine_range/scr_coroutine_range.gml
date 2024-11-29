

/// @func CoroutineRange();
/// @desc Creates iterable range (start, stop, step)
function CoroutineRange() constructor
{
  // Declare variables.
  start = 0;
  stop = 0;
  step = 1;
  
  
  switch(argument_count)
  {
    // Either only length is set, or parameters are given as struct.
    case 1:
    {
      var _item = argument[0];
      if (is_struct(_item))
      {
        start = _item[$ "start"] ?? start;
        stop = _item[$ "stop"] ?? stop;
        step = _item[$ "step"] ?? sign(stop - start);
      }
      else
      {
        // Count from zero towards number.
        start = 0;
        stop = _item;
        step = sign(_item);
      }
      break;
    }
  
    // Start and stop are set.
    case 2:
    {
      start = argument[0];
      stop = argument[1];
      step = sign(stop - start);
      break;
    }
  
    // All are set: start, stop and step 
    case 3: 
    {
      start = argument[0];
      stop = argument[1];
      step = argument[2];
      break;
    }
  
    // Not acceptable.
    default:
    {
      throw("RANGE has invalid amount of arguments.");
      break;
    }
  }
  
  // Sanity check.
  if (step == 0)
  {
    throw("RANGE step-size must not be zero.");
  }
}



