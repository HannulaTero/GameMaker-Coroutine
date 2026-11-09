

/**
* Checks whether string is keyword.
* 
* @param {String} _identifier
*/ 
function KorutiiniBuilderScanner_IsKeyword(_identifier)
{
  static lookup = KorutiiniBuilderScanner_MapKeywords();
  return (lookup[$ _identifier] != undefined);
}