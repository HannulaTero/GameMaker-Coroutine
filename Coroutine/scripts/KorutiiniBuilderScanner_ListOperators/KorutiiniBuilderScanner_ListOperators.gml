

/**
* Returns list of GML operators.
*/ 
function KorutiiniBuilderScanner_ListOperators()
{
  static operators = [
    ",", 
    ".", 
    "~",
    "$",
    "@",
    "#",
    "++",
    "--",
    "<>",
    "?", ":", 
    "=", "==",
    "!", "!=",
    "+", "+=",
    "-", "-=",
    "*", "*=",
    "/", "/=",
    "%", "%=",
    "&", "&=", 
    "|", "|=", 
    "^", "^=", 
    "<", "<=", 
    ">", ">=", 
    "&&", "&&=",
    "||", "||=",
    "^^", "^^=",
    "<<", "<<=",
    ">>", ">>=",
    "??", "??=",
    "(", ")",
    "[", "]",
    "{", "}",
    "#region",
    "#endregion",
    "#macro",
    "#export",
  ];
  
  return operators;
}