/// @desc CLEANUP.
if (skipped) exit;

if (sound != undefined)
  audio_free_buffer_sound(sound);  

buffer_delete(buffer);
