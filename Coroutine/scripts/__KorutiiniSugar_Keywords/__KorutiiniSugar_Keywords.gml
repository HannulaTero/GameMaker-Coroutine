// feather ignore GM1051 - To ignore ending macros with semicolons. 
//=============================================================
// 
#region INFORMATION
//
/*
  
  The macros are only meant to give proper syntax highlighting
  and guide the feather, which should help user.
  The macros don't need to produce executable coroutine,
  insteas it is handled by the builder.
  
*/
//
#endregion
//
//=============================================================
// 
#region MAIN HANDLE.


#macro __KORUTIINISUGAR_KEYWORD__KORUTIINI    __KorutiiniSugar_GetEntrypoint(_GMFILE_, _GMLINE_) ?? function
#macro __KORUTIINISUGAR_KEYWORD__DISPATCH     __KORUTIINISUGAR_KEYWORD__KORUTIINI


#endregion
//
//=============================================================
// 
#region KORUTIINI TRIGGERS.


#macro __KORUTIINISUGAR_KEYWORD__ON_INIT      if (false) { } else 
#macro __KORUTIINISUGAR_KEYWORD__ON_YIELD     if (false) { } else 
#macro __KORUTIINISUGAR_KEYWORD__ON_PAUSE     if (false) { } else 
#macro __KORUTIINISUGAR_KEYWORD__ON_LAUNCH    if (false) { } else 
#macro __KORUTIINISUGAR_KEYWORD__ON_RESUME    if (false) { } else 
#macro __KORUTIINISUGAR_KEYWORD__ON_CANCEL    if (false) { } else 
#macro __KORUTIINISUGAR_KEYWORD__ON_COMPLETE  if (false) { } else 
#macro __KORUTIINISUGAR_KEYWORD__ON_CLEANUP   if (false) { } else 
#macro __KORUTIINISUGAR_KEYWORD__ON_ERROR     if (false) { } else 


#endregion
//
//=============================================================
// 
#region KORUTIINI STATEMENTS, GENERAL


#macro __KORUTIINISUGAR_KEYWORD__SET        if (false) { } else __KorutiiniSugar_Feather_Set
#macro __KORUTIINISUGAR_KEYWORD__LABEL      if (false) { } else __KorutiiniSugar_Feather_Label
#macro __KORUTIINISUGAR_KEYWORD__YIELD      if (false) { } else __KorutiiniSugar_Feather_Yield
#macro __KORUTIINISUGAR_KEYWORD__PAUSE      if (false) { } else __KorutiiniSugar_Feather_Pause


#endregion
//
//=============================================================
// 
#region KORUTIINI DELAY & AWAIT.


#macro __KORUTIINISUGAR_KEYWORD__DELAY            if (false) { } else __KorutiiniSugar_Feather_Delay

#macro __KORUTIINISUGAR_KEYWORD__AWAIT            if (false) { } else __KorutiiniSugar_Feather_Await
#macro __KORUTIINISUGAR_KEYWORD__AWAIT_ASYNC      if (false) { } else __KorutiiniSugar_Feather_AwaitAsync
#macro __KORUTIINISUGAR_KEYWORD__AWAIT_KORUTIINI  if (false) { } else __KorutiiniSugar_Feather_AwaitKorutiini
#macro __KORUTIINISUGAR_KEYWORD__AWAIT_BROADCAST  if (false) { } else __KorutiiniSugar_Feather_AwaitBroadcast

#macro __KORUTIINISUGAR_KEYWORD__AWAIT_SUBTASKS   if (false) { } else __KorutiiniSugar_Feather_AwaitSubtasks
#macro __KORUTIINISUGAR_KEYWORD__AWAIT_REQUESTS   if (false) { } else __KorutiiniSugar_Feather_AwaitRequests
#macro __KORUTIINISUGAR_KEYWORD__AWAIT_LISTENERS  if (false) { } else __KorutiiniSugar_Feather_AwaitListeners


#endregion
//
//=============================================================
// 
#region KORUTIINI BRANCHES & LOOPS.


#macro __KORUTIINISUGAR_KEYWORD__LOOP       while(choose(true, false))
#macro __KORUTIINISUGAR_KEYWORD__FOREACH    for         // TODO
#macro __KORUTIINISUGAR_KEYWORD__IN         = 0;; i =   // TODO
#macro __KORUTIINISUGAR_KEYWORD__RANGE      __KorutiiniSugar_Feather_Range // TODO
#macro __KORUTIINISUGAR_KEYWORD__VIEW       __KorutiiniSugar_Feather_View  // TODO


#endregion
//
//=============================================================
// 
#region KORUTIINI OTHER STATEMENTS.


#macro __KORUTIINISUGAR_KEYWORD__RESTART  if (false) { } else return 
#macro __KORUTIINISUGAR_KEYWORD__CANCEL   if (false) { } else return 
#macro __KORUTIINISUGAR_KEYWORD__GOTO     if (false) { } else return 
#macro __KORUTIINISUGAR_KEYWORD__PRINT    if (false) { } else return 


#endregion
//
//=============================================================
// 
#region KORUTIINI ASYNC REQUESTS.


#macro __KORUTIINISUGAR_KEYWORD__ASYNC_REQUEST    if (false) { } else 
#macro __KORUTIINISUGAR_KEYWORD__ASYNC_LISTENER   if (false) { } else 
#macro __KORUTIINISUGAR_KEYWORD__DO_REQUEST       if (false) { } else 
#macro __KORUTIINISUGAR_KEYWORD__ON_PENDING       if (false) { } else 
#macro __KORUTIINISUGAR_KEYWORD__ON_SUCCESS       if (false) { } else 
#macro __KORUTIINISUGAR_KEYWORD__ON_FAILURE       if (false) { } else 
#macro __KORUTIINISUGAR_KEYWORD__ON_TIMEOUT       if (false) { } else 
#macro __KORUTIINISUGAR_KEYWORD__ON_LISTEN        if (false) { } else 


#endregion
//
//=============================================================