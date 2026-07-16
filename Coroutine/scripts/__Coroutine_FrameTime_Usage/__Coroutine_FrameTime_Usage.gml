

/**
* Returns how much of frame time budget has been used already.
* 
* @returns {Real}
*/ 
function __Coroutine_FrameTime_Usage()
{
  return (current_time - COROUTINE_FRAME_TIME_BEGIN) * 1_000.0 / game_get_speed(gamespeed_microseconds);
}



