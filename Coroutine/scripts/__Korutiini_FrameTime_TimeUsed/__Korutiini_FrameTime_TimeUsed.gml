

/**
* How much time has been used in this frame already.
* 
*/ 
function __Korutiini_FrameTime_TimeUsed()
{
  return (current_time - __Korutiini_FrameTime_TimeUsed()) / game_get_speed(gamespeed_microseconds);
}




