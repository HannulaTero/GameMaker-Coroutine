

/**
* Returns keywords for KorutiiniSugar.
* 
* User might have decided to change to macros (which is allowed),
* therefore it must be fetched, so parsing can be done correctly.
* -> Sugar Keywords are updated during building process.
*/ 
function KorutiiniBuilder_Keywords()
{
  static keywords = {
    
    // Korutiini Sugar keywords
    "KORUTIINI"       : "",
    "DISPATCH"        : "",
    "ON_INIT"         : "",
    "ON_YIELD"        : "",
    "ON_PAUSE"        : "",
    "ON_LAUNCH"       : "",
    "ON_RESUME"       : "",
    "ON_CANCEL"       : "",
    "ON_COMPLETE"     : "",
    "ON_CLEANUP"      : "",
    "ON_ERROR"        : "",
    "SET"             : "",
    "LABEL"           : "",
    "YIELD"           : "",
    "PAUSE"           : "",
    "DELAY"           : "",
    "AWAIT"           : "",
    "AWAIT_ASYNC"     : "",
    "AWAIT_KORUTIINI" : "",
    "AWAIT_BROADCAST" : "",
    "AWAIT_SUBTASKS"  : "",
    "AWAIT_REQUESTS"  : "",
    "AWAIT_LISTENERS" : "",
    "LOOP"            : "",
    "FOREACH"         : "",
    "IN"              : "",
    "RANGE"           : "",
    "VIEW"            : "",
    "RESTART"         : "",
    "CANCEL"          : "",
    "GOTO"            : "",
    "PRINT"           : "",
    
    // GML keywords.
    "IF"        : "if",
    "ELSE"      : "else",
    "SWITCH"    : "switch",
    "CASE"      : "case",
    "DEFAULT"   : "default",
    "FOR"       : "for",
    "WHILE"     : "while",
    "WITH"      : "with",
    "DO"        : "do",
    "UNTIL"     : "until",
    "REPEAT"    : "repeat",
    "CONTINUE"  : "continue",
    "BREAK"     : "break",
    "RETURN"    : "return",
    "EXIT"      : "exit",
  };
  
  return keywords;
}