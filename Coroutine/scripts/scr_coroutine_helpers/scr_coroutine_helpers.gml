

/// @func coroutine_mapping(_array);
/// @desc
/// @param {Array<Any>} _array
/// @returns {Struct}
function coroutine_mapping(_array)
{
  var _mapping = {};
  var _countOuter = array_length(_array);
  for(var i = 0; i < _countOuter; i+=2)
  {
    var _lhs = _array[i + 0];
    var _rhs = _array[i + 1];
    _rhs = method(undefined, _rhs);
    
    var _countInner = array_length(_lhs);
    for(var j = 0; j < _countInner; j++)
    {
      _mapping[$ _lhs[j]] = _rhs;
    }
  }
  return _mapping;
}


/// @func coroutine_frame_time_get();
/// @desc Tells how much time has passed since frame started.
/// @returns {Real}
function coroutine_frame_time_get()
{
  return (get_timer() - __COROUTINE_FRAME_TIME_BEGIN);
}


/// @func coroutine_frame_time_usage();
/// @desc Returns how much of frame time budget has been used already.
/// @returns {Real}
function coroutine_frame_time_usage()
{
  return coroutine_frame_time_get() / game_get_speed(gamespeed_microseconds);
}

