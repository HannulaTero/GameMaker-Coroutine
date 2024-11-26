

image_blend = make_color_hsv(0, 0, 200);

image_blend = coroutine.isDelayed()
  ? make_color_hsv(32, 128, 200)
  : image_blend;

image_blend = coroutine.isPaused()
  ? make_color_hsv(0, 255, 128)
  : image_blend;
  
image_blend = coroutine.isFinished()
  ? make_color_hsv(90, 128, 128)
  : image_blend;
  