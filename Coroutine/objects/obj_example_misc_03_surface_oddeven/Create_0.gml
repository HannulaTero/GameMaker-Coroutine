/// @desc RENDERING.



task = COROUTINE
  ON_INIT
    size = [256, 256];
    dtype = buffer_f32;
    dsize = buffer_sizeof(dtype);
    count = size[0] * size[1];
    bytes = count * dsize * 4;
    buffer = buffer_create(bytes, buffer_fixed, dsize);
    surface = -1;
    
  BEGIN
  
  // Generate random data for buffer to put into surface.
  COROUTINE BEGIN
    show_debug_message("Start generating buffer data.");
    left = this.count;
    chunk = 256;
    dtype = this.dtype;
    buffer = this.buffer;
    buffer_seek(buffer, buffer_seek_start, 0);
      index = 0;
    WHILE left > 0 THEN
      repeat(min(left, chunk))
      {
        buffer_write(buffer, dtype, random(1.0));
        buffer_write(buffer, dtype, random_range(0.2, 0.4));
        buffer_write(buffer, dtype, random_range(0.2, 0.4));
        buffer_write(buffer, dtype, 1.0);
      }
      left -= chunk;
    END
    show_debug_message("Buffer filled.");
  FINISH DISPATCH 
  AWAIT_SUBTASKS
  
  
  // Put data into surface.
  surface = surface_create(size[0], size[1], surface_rgba32float);
  buffer_set_surface(buffer, surface, 0);
  
  
  // Start sorting.
  // Uses odd-even sort, which is highly inefficient.
  // For practical purposes, use any other sorting mehtod.
  COROUTINE
    ON_INIT
      shader = shd_example_sort_oddeven;
      uniLayout = shader_get_uniform(shader, "uniLayout");
      uniOffset = shader_get_uniform(shader, "uniOffset");
      uniCount = shader_get_uniform(shader, "uniCount");
      
      iterations = 0;
      timer = 0;
      size = this.size;
      count = this.count;
      tempA = this.surface;
      tempB = undefined;
      tempC = undefined;
  
    ON_LAUNCH
      show_debug_message($"took {(get_timer() - timer) / 1_000.0} ms.");
      iterations = 0;
      timer = get_timer();
      if (!surface_exists(tempA))
      {
        tempA = surface_create(size[0], size[1], surface_rgba32float);
      }
      if (!surface_exists(tempB))
      {
        tempB = surface_create(size[0], size[1], surface_rgba32float);
      }
      shader_set(shader);
      shader_set_uniform_f_array(uniLayout, size);
      shader_set_uniform_f(uniCount, count);
      gpu_push_state();
      gpu_set_blendenable(false);
      gpu_set_blendmode_ext(bm_one, bm_zero);
      gpu_set_tex_filter(true);
      gpu_set_tex_repeat(false);
    
    ON_YIELD
      gpu_pop_state();
      shader_reset();
      show_debug_message($"made {iterations} iterations.");
      show_debug_message($"took {(get_timer() - timer) / 1_000.0} ms.");
    
    BEGIN
      show_debug_message("Started sorting.");
      chunk = 256;
      FOREACH i: key IN RANGE(0, this.count, chunk) THEN
        FOR  j = 0;
        COND j < chunk;
        ITER j++;
        THEN
          shader_set_uniform_f(uniOffset, (i + j) mod 2);
          surface_set_target(tempB);
          draw_surface(tempA, 0, 0);
          surface_reset_target();
          tempC = tempB;
          tempB = tempA;
          tempA = tempC;
          iterations++;
        END
        YIELD
      END
      show_debug_message("Surface sorted.");
  
    FINISH 
  DISPATCH
  AWAIT_SUBTASKS
  
  
  // Destroy the surface.
  DELAY 5 SECONDS
  if (surface_exists(surface))
  {
    surface_free(surface);
  }
    
FINISH DISPATCH