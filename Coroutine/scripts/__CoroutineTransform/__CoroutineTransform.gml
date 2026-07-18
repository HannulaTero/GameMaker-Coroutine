

/**
* For transforming AST nodes into directed graph.
*
* The Generator cases are functions mapped in struct.
* Could use large switch-statement instead, but in GML it is just fancy if-else -chain.
* So with enough cases, having explicit lookup-table is faster in general case.
* 
* These generator functions should be struct.
* - Struct should have atleast "execute" and "next" -members.
* - "execute" and "next should both be functions, which are called during execution.
* - Returning struct also works as context, which handle/direct the functions execution.
*   
* Executive functions assume, that manager calls, and global state is proper.
* - Functions change global state to lead execution to next state.
*/ 
function __CoroutineTransform() constructor
{
  // Shared common nodes.
  static finalNode      = __CoroutineTransform__nodeFinal();
  static errorBreak     = __CoroutineTransform__nodeErrorBreak();
  static errorContinue  = __CoroutineTransform__nodeErrorContinue();  
  
  
  // Static methods.
  static Dispatch = __CoroutineTransform__Dispatch;
  static Generate = __CoroutineTransform__Generate;  
  
  
  // Static lookup-table cases for generators.
  static cases = __Coroutine_Mapping(
    "AWAIT_ASYNC",      __CoroutineTransform__Case_AWAIT_COROUTINE,
    "AWAIT_BROADCAST",  __CoroutineTransform__Case_AWAIT_BROADCAST,
    "AWAIT_COND",       __CoroutineTransform__Case_AWAIT_COND,
    "AWAIT_COROUTINE",  __CoroutineTransform__Case_AWAIT_COROUTINE,
    "AWAIT_LISTENERS",  __CoroutineTransform__Case_AWAIT_LISTENERS,
    "AWAIT_REQUESTS",   __CoroutineTransform__Case_AWAIT_REQUESTS,
    "AWAIT_SUBTASKS",   __CoroutineTransform__Case_AWAIT_SUBTASKS,
    "BLOCK",            __CoroutineTransform__Case_BLOCK,
    "DELAY",            __CoroutineTransform__Case_DELAY,
    "DO",               __CoroutineTransform__Case_DO,
    "FINISH",           __CoroutineTransform__Case_FINISH,
    "FOR",              __CoroutineTransform__Case_FOR,
    "FOREACH",          __CoroutineTransform__Case_FOREACH,
    "IF",               __CoroutineTransform__Case_IF,
    "LABEL",            __CoroutineTransform__Case_LABEL,
    "LOOP",             __CoroutineTransform__Case_LOOP,
    "PAUSE",            __CoroutineTransform__Case_PAUSE,
    "PAUSE_SET",        __CoroutineTransform__Case_PAUSE_SET,
    "REPEAT",           __CoroutineTransform__Case_REPEAT,
    "SET",              __CoroutineTransform__Case_SET,
    "STMT",             __CoroutineTransform__Case_STMT,
    "SWITCH",           __CoroutineTransform__Case_SWITCH,
    "WHILE",            __CoroutineTransform__Case_WHILE,
    "YIELD",            __CoroutineTransform__Case_YIELD,
    "YIELD_SET",        __CoroutineTransform__Case_YIELD_SET,
  );
  
  
  // Variables.
  labels    = { };
  tables    = [ ];
  final     = undefined;
  register  = 0;
}















