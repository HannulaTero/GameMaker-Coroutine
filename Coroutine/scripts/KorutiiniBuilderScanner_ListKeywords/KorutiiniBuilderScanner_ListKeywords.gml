

/**
* Returns list of GML keywords.
*/ 
function KorutiiniBuilderScanner_ListKeywords()
{
  static keywords = [
    "if",
    "else",
    "switch",
    "case",
    "default",
    "for",
    "while",
    "do",
    "until",
    "repeat",
    "continue",
    "break",
    "return",
    "exit",
    "try",
    "catch", 
    "finally", 
    "throw", 
    "new",
    "delete",
    "mod", 
    "div",
    "or",
    "xor",
    "and",
    "not",
    "true",
    "false",
    "undefined",
    "infinity",
    "var",
    "globalvar",
    "then",
    "begin",
    "with",
    "enum",
    "function",
    "constructor",
    "static",
  ];
  
  return keywords;
}

