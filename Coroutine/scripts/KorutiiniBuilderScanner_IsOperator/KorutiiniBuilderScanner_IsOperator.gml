

/**
* Checks whether string is keyword.
* 
* @param {String} _operator
*/ 
function KorutiiniBuilderScanner_IsOperator(_operator)
{
  static lookup = KorutiiniBuilderScanner_MapOperators();
  return (lookup[$ _operator] != undefined);
}