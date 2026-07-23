

#macro KORUTIINI_NAME       ("Korutiini")
#macro KORUTIINI_DESC       ("Coroutines for GML")
#macro KORUTIINI_AUTHOR     ("Tero Hannula")
#macro KORUTIINI_VERSION    ("v2026.07.16.0")
#macro KORUTIINI_URL        ("https://github.com/HannulaTero/GameMaker-Coroutine")


#macro KORUTIINI_CURRENT_TASK       global.__gKORUTIINI_CURRENT_TASK      // Active coroutine task which is currently being executed.
#macro KORUTIINI_CURRENT_EXECUTE    global.__gKORUTIINI_CURRENT_EXECUTE   // Current executable callback of current coroutine.
#macro KORUTIINI_CURRENT_LOCAL      global.__gKORUTIINI_CURRENT_LOCAL     // Current coroutine's hidden local variables.
#macro KORUTIINI_CURRENT_SCOPE      global.__gKORUTIINI_CURRENT_SCOPE     // Current coroutine's variables.
#macro KORUTIINI_CURRENT_YIELDED    global.__gKORUTIINI_CURRENT_YIELDED   // Whether current coroutine has yielded.


// For keeping single manager of each.
#macro KORUTIINI_SINGLETON \
  if (instance_number(object_index) > 1) \
  { instance_destroy(); exit; } 
