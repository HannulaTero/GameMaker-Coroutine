/// @desc CLEANUP.

// Some examples might have created files.
if (file_exists("buffer.save"))
  file_delete("buffer.save");