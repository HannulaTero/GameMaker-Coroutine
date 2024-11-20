

/// @func CoroutineRange();
/// @desc Creates iterable range (start, stop, step)
function CoroutineRange() constructor
{
  // Declare variables.
  self.start = 0;
  self.stop = 0;
  self.step = 1;
  
  
  // Single argument.
  switch(argument_count)
  {
    case 1:
    {
      // Either only length is set, or parameters are given as struct.
      var _item = argument[0];
      if (is_struct(_item))
      {
        self.start = _item[$ "start"] ?? start;
        self.stop = _item[$ "stop"] ?? stop;
        self.step = _item[$ "step"] ?? step;
      }
      else
      {
        self.stop = _item;
      }
      break;
    }
  
    // Start and stop are set.
    case 2:
    {
      self.start = argument[0];
      self.stop = argument[1];
      break;
    }
  
    // All are set: start, stop and step 
    case 3: 
    {
      self.start = argument[0];
      self.stop = argument[1];
      self.step = argument[2];
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



