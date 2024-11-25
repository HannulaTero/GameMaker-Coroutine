/*

image_blend = coroutine.isPaused()
  ? make_color_hsv(0, 255, 128)
  : c_dkgray;
  
image_blend = coroutine.isFinished()
  ? make_color_hsv(90, 128, 128)
  : image_blend;
  