/// @desc SINGLETON.
KORUTIINI_SINGLETON


// Set as last instance to draw.
depth = +15_999; // Note that execution order based on depth is actually undefined behaviour!


// Initialize the statics.
__Korutiini_FrameTime_FrameBegin(); 
__Korutiini_FrameTime_FrameCounter(); 
__Korutiini_FrameTime_FrameBegin.value = current_time;


