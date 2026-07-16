//=============================================================
// 
#region INFORMATION
//
/*
  
  These are all available Coroutine -keywords.
  
  You may change the definitions as you wish, keep the definition.
  -> This can be useful, if you have some conflicting macros.
  
*/
//
#endregion
//
//=============================================================
// 
#region MAIN HANDLE.


#macro COROUTINE        __COROUTINE_KEYWORD__COROUTINE 
#macro BEGIN            __COROUTINE_KEYWORD__BEGIN
#macro FINISH           __COROUTINE_KEYWORD__FINISH


#endregion
//
//=============================================================
// 
#region COROUTINE TRIGGERS.


#macro ON_INIT          __COROUTINE_KEYWORD__ON_INIT
#macro ON_YIELD         __COROUTINE_KEYWORD__ON_YIELD
#macro ON_PAUSE         __COROUTINE_KEYWORD__ON_PAUSE
#macro ON_LAUNCH        __COROUTINE_KEYWORD__ON_LAUNCH
#macro ON_RESUME        __COROUTINE_KEYWORD__ON_RESUME
#macro ON_CANCEL        __COROUTINE_KEYWORD__ON_CANCEL
#macro ON_COMPLETE      __COROUTINE_KEYWORD__ON_COMPLETE
#macro ON_CLEANUP       __COROUTINE_KEYWORD__ON_CLEANUP
#macro ON_ERROR         __COROUTINE_KEYWORD__ON_ERROR


#endregion
//
//=============================================================
// 
#region COROUTINE STATEMENTS, GENERAL


#macro THEN             __COROUTINE_KEYWORD__THEN
#macro PASS             __COROUTINE_KEYWORD__PASS
#macro SET              __COROUTINE_KEYWORD__SET
#macro END              __COROUTINE_KEYWORD__END
#macro DISPATCH         __COROUTINE_KEYWORD__DISPATCH

#macro LABEL            __COROUTINE_KEYWORD__LABEL
#macro YIELD            __COROUTINE_KEYWORD__YIELD
#macro PAUSE            __COROUTINE_KEYWORD__PAUSE
#macro YIELD_SET        __COROUTINE_KEYWORD__YIELD_SET
#macro PAUSE_SET        __COROUTINE_KEYWORD__PAUSE_SET


#endregion
//
//=============================================================
// 
#region COROUTINE DELAY.


#macro DELAY            __COROUTINE_KEYWORD__DELAY
#macro MICROS           __COROUTINE_KEYWORD__MICROS
#macro MILLIS           __COROUTINE_KEYWORD__MILLIS
#macro FRAMES           __COROUTINE_KEYWORD__FRAMES
#macro SECONDS          __COROUTINE_KEYWORD__SECONDS


#endregion
//
//=============================================================
// 
#region COROUTINE AWAIT.


#macro AWAIT            __COROUTINE_KEYWORD__AWAIT
#macro AWAIT_ASYNC      __COROUTINE_KEYWORD__AWAIT_ASYNC
#macro AWAIT_COROUTINE  __COROUTINE_KEYWORD__AWAIT_COROUTINE
#macro AWAIT_BROADCAST  __COROUTINE_KEYWORD__AWAIT_BROADCAST

#macro AWAIT_SUBTASKS   __COROUTINE_KEYWORD__AWAIT_SUBTASKS
#macro AWAIT_REQUESTS   __COROUTINE_KEYWORD__AWAIT_REQUESTS
#macro AWAIT_LISTENERS  __COROUTINE_KEYWORD__AWAIT_LISTENERS


#endregion
//
//=============================================================
// 
#region COROUTINE BRANCHING


#macro IF               __COROUTINE_KEYWORD__IF
#macro ELIF             __COROUTINE_KEYWORD__ELIF
#macro ELSE             __COROUTINE_KEYWORD__ELSE

#macro SWITCH           __COROUTINE_KEYWORD__SWITCH
#macro CASE             __COROUTINE_KEYWORD__CASE
#macro DEFAULT          __COROUTINE_KEYWORD__DEFAULT


#endregion
//
//=============================================================
// 
#region COROUTINE LOOPS.


#macro LOOP             __COROUTINE_KEYWORD__LOOP
#macro WHILE            __COROUTINE_KEYWORD__WHILE
#macro REPEAT           __COROUTINE_KEYWORD__REPEAT
#macro DO               __COROUTINE_KEYWORD__DO
#macro UNTIL            __COROUTINE_KEYWORD__UNTIL

#macro FOR              __COROUTINE_KEYWORD__FOR
#macro COND             __COROUTINE_KEYWORD__COND
#macro ITER             __COROUTINE_KEYWORD__ITER

#macro FOREACH          __COROUTINE_KEYWORD__FOREACH
#macro IN               __COROUTINE_KEYWORD__IN
#macro RANGE            __COROUTINE_KEYWORD__RANGE
#macro VIEW             __COROUTINE_KEYWORD__VIEW


#endregion
//
//=============================================================
// 
#region COROUTINE RUNTIME EVALUATED STATEMENTS.


#macro RESTART          __COROUTINE_KEYWORD__RESTART
#macro CONTINUE         __COROUTINE_KEYWORD__CONTINUE
#macro BREAK            __COROUTINE_KEYWORD__BREAK
#macro EXIT             __COROUTINE_KEYWORD__EXIT
#macro CANCEL           __COROUTINE_KEYWORD__CANCEL
#macro RETURN           __COROUTINE_KEYWORD__RETURN
#macro GOTO             __COROUTINE_KEYWORD__GOTO
#macro PRINT            __COROUTINE_KEYWORD__PRINT


#endregion
//
//=============================================================
// 
#region COROUTINE ASYNC REQUESTS.


#macro ASYNC_REQUEST    __COROUTINE_KEYWORD__ASYNC_REQUEST
#macro ASYNC_LISTENER   __COROUTINE_KEYWORD__ASYNC_LISTENER
#macro DO_REQUEST       __COROUTINE_KEYWORD__DO_REQUEST
#macro ON_PENDING       __COROUTINE_KEYWORD__ON_PENDING
#macro ON_SUCCESS       __COROUTINE_KEYWORD__ON_SUCCESS
#macro ON_FAILURE       __COROUTINE_KEYWORD__ON_FAILURE
#macro ON_TIMEOUT       __COROUTINE_KEYWORD__ON_TIMEOUT
#macro ON_LISTEN        __COROUTINE_KEYWORD__ON_LISTEN
#macro ASYNC_END        __COROUTINE_KEYWORD__ASYNC_END


#endregion
//
//=============================================================