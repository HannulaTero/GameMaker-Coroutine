

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
function __KorutiiniTransform() constructor
{
  // Shared common nodes.
  static finalNode      = __KorutiiniTransform__nodeFinal();
  static errorBreak     = __KorutiiniTransform__nodeErrorBreak();
  static errorContinue  = __KorutiiniTransform__nodeErrorContinue();  
  
  
  // Static methods.
  static Dispatch = __KorutiiniTransform__Dispatch;
  static Generate = __KorutiiniTransform__Generate;  
  
  
  // Static lookup-table cases for generators.
  static cases = __Korutiini_Mapping(
    "AWAIT_ASYNC",      __KorutiiniTransform__Case_AWAIT_KORUTIINI,
    "AWAIT_BROADCAST",  __KorutiiniTransform__Case_AWAIT_BROADCAST,
    "AWAIT_COND",       __KorutiiniTransform__Case_AWAIT_COND,
    "AWAIT_KORUTIINI",  __KorutiiniTransform__Case_AWAIT_KORUTIINI,
    "AWAIT_LISTENERS",  __KorutiiniTransform__Case_AWAIT_LISTENERS,
    "AWAIT_REQUESTS",   __KorutiiniTransform__Case_AWAIT_REQUESTS,
    "AWAIT_SUBTASKS",   __KorutiiniTransform__Case_AWAIT_SUBTASKS,
    "BLOCK",            __KorutiiniTransform__Case_BLOCK,
    "DELAY",            __KorutiiniTransform__Case_DELAY,
    "DO",               __KorutiiniTransform__Case_DO,
    "FINISH",           __KorutiiniTransform__Case_FINISH,
    "FOR",              __KorutiiniTransform__Case_FOR,
    "FOREACH",          __KorutiiniTransform__Case_FOREACH,
    "IF",               __KorutiiniTransform__Case_IF,
    "LABEL",            __KorutiiniTransform__Case_LABEL,
    "LOOP",             __KorutiiniTransform__Case_LOOP,
    "PAUSE",            __KorutiiniTransform__Case_PAUSE,
    "PAUSE_SET",        __KorutiiniTransform__Case_PAUSE_SET,
    "REPEAT",           __KorutiiniTransform__Case_REPEAT,
    "SET",              __KorutiiniTransform__Case_SET,
    "STMT",             __KorutiiniTransform__Case_STMT,
    "SWITCH",           __KorutiiniTransform__Case_SWITCH,
    "WHILE",            __KorutiiniTransform__Case_WHILE,
    "YIELD",            __KorutiiniTransform__Case_YIELD,
    "YIELD_SET",        __KorutiiniTransform__Case_YIELD_SET,
  );
  
  
  // Variables.
  labels    = { };
  tables    = [ ];
  final     = undefined;
  register  = 0;
}















