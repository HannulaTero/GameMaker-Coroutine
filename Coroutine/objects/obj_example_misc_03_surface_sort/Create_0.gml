/// @desc SURFACE ODD-EVENT SORT.

image_blend = c_black;
image_xscale = 256;
image_yscale = 256;
x = room_width - image_xscale - 32
y = room_height - image_yscale - 32;
repeat(instance_number(object_index))
{
  if (collision_point(x, y, object_index, false, true))
  {
    x -= image_xscale + 32;
  }
}



// This example does odd-even sort for surface using red-channel as sorting value.
// Note! odd-even sort scales really badly (similar to bubble-sort), and should not be used in practice, atleast for large sets.
// This is chosen example just because it takes so much time to iterate over, that coroutines are required to not halt the game.


task = COROUTINE
ON_INIT
  // Initialize the datastructure.
  size = [256, 256];
  dtype = buffer_u8;
  dsize = buffer_sizeof(dtype);
  count = size[0] * size[1];
  bytes = count * dsize * 4;
  buffer = buffer_create(bytes, buffer_fixed, dsize);
  surface = -1;
  
    
BEGIN

  // Generate random data for buffer to put into surface.
  SET "Generating\nBuffer data" PASS
  COROUTINE BEGIN
    show_debug_message("Start generating buffer data.");
    left = this.count;
    chunk = 256;
    dtype = this.dtype;
    buffer = this.buffer;
    buffer_seek(buffer, buffer_seek_start, 0);
    WHILE left > 0 THEN
      repeat(min(left, chunk))
      {
        buffer_write(buffer, dtype, irandom(255));
        buffer_write(buffer, dtype, irandom_range(64, 96));
        buffer_write(buffer, dtype, irandom_range(64, 96));
        buffer_write(buffer, dtype, 255);
      }
      left -= chunk;
    END
    show_debug_message("Buffer filled.");
    show_debug_message($"----------------------------------------");
  FINISH DISPATCH 
  AWAIT_SUBTASKS
  
  
  // Put data into surface.
  SET "Pushing\nData to Surface" PASS
  surface = surface_create(size[0], size[1]);
  buffer_set_surface(buffer, surface, 0);
  SET "Random pixels" PASS
  DELAY 2 SECONDS  
  
  // Start sorting.
  // Uses odd-even sort, which is highly inefficient.
  // For practical purposes, use any other sorting mehtod.
  SET "Sorting..." PASS
  COROUTINE
    ON_INIT
      shader = shd_example_sort_oddeven;
      uniLayout = shader_get_uniform(shader, "uniLayout");
      uniOffset = shader_get_uniform(shader, "uniOffset");
      uniCount = shader_get_uniform(shader, "uniCount");
      
      iterations = 0;
      timer = get_timer();
      size = this.size;
      count = this.count;
      tempA = this.surface;
      tempB = undefined;
      tempC = undefined;
    
  
    // When launches, set up the gpu state.
    ON_LAUNCH
      iterations = 0;
      timer = get_timer();
      if (!surface_exists(tempA))
      {
        tempA = surface_create(size[0], size[1]);
      }
      if (!surface_exists(tempB))
      {
        tempB = surface_create(size[0], size[1]);
      }
      shader_set(shader);
      shader_set_uniform_f_array(uniLayout, size);
      shader_set_uniform_f(uniCount, count);
      gpu_push_state();
      gpu_set_blendenable(false);
      gpu_set_blendmode_ext(bm_one, bm_zero);
      gpu_set_tex_filter(true);
      gpu_set_tex_repeat(false);
    
    
    // Return previous gpu state, print progress.
    ON_YIELD
      gpu_pop_state();
      shader_reset();
      show_debug_message($"did {iterations} iterations.");
      show_debug_message($"time taken {(get_timer() - timer) / 1_000.0} ms.");
      show_debug_message($"progress {(i / this.count) * 100.0} %.");
      show_debug_message($"----------------------------------------");
    
    
    // Make sure final results are stored in target surface.
    ON_COMPLETE
      if (surface_exists(tempB))
      && (this.surface != tempA)
      {
        surface_copy(this.surface, 0, 0, tempA);
      }
      if (surface_exists(tempB))
      {
        surface_free(tempB);
      }
    
    
    // Do the actual sorting. Do in chunks, so coroutine can pause.
    BEGIN
      show_debug_message("Started sorting.");
      wchunk = min(128, this.size[0]);
      hchunk = min(128, this.size[1]);
    
      // The odd-event sort requires as many iterations as there are inputs.
      // It has time-complexity O(N) and work-complexity of O(N^2), which are pretty bad.
      FOREACH i: value IN RANGE(0, this.count) THEN
    
        // Chunkify, if input/output are large.
        FOR xpos = 0; COND xpos < this.size[0]; ITER xpos += wchunk THEN
        FOR ypos = 0; COND ypos < this.size[1]; ITER ypos += hchunk THEN
          shader_set_uniform_f(uniOffset, i mod 2);
          surface_set_target(tempB);
          draw_surface_stretched(tempA, xpos, ypos, wchunk, hchunk);
          surface_reset_target();
        END END
      
        tempC = tempB;
        tempB = tempA;
        tempA = tempC;
        iterations++;
      END
      show_debug_message("Surface sorted.");
    FINISH
  DISPATCH
  AWAIT_SUBTASKS
  
  
  // After finishing show results just a while, then destroy the surface.
  SET "Surface\nSorted!" PASS
  DELAY 5 SECONDS
  if (surface_exists(surface))
  {
    surface_free(surface);
  }
  instance_destroy(this);
    
FINISH DISPATCH



