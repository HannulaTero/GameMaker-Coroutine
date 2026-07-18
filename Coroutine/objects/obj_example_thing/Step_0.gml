

image_blend = make_color_hsv(0, 0, 100);

image_blend = coroutine.IsDelayed()
  ? make_color_hsv(32, 128, 128)
  : image_blend;

image_blend = coroutine.IsPaused()
  ? make_color_hsv(0, 255, 128)
  : image_blend;
  
image_blend = coroutine.IsFinished()
  ? make_color_hsv(90, 128, 128)
  : image_blend;
  