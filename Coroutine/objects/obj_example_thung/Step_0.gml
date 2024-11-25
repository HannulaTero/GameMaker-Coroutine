

image_blend = coroutine.isPaused()
  ? make_color_hsv(0, 240, 240)
  : c_gray;
  
image_blend = coroutine.isFinished()
  ? make_color_hsv(90, 128, 128)
  : image_blend;
  
  
