

// Warm up the pipeline by using Korutiini.
// This way statics and lookup tables are initialized at game-start.
KORUTIINI BEGIN
  show_debug_message("Warming up {0}...", KORUTIINI_NAME);
  
  DELAY 5 FRAMES
  
  var _line = string_repeat("=", 92);
  show_debug_message(
    string_concat(
      $"\n\n",
      $"{_line} \n\n",
      $"Welcome using {KORUTIINI_NAME}! \n",
      $" - {KORUTIINI_DESC} \n",
      $" - You are in version: {KORUTIINI_VERSION} \n",
      $" - Provided by {KORUTIINI_AUTHOR} \n",
      $" - URL: {KORUTIINI_URL} \n\n",
      $"{_line} \n\n",
    )
  );

FINISH DISPATCH

