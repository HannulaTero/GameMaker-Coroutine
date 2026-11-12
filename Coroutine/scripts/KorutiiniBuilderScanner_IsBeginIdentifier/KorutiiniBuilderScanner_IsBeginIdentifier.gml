

/**
* Checks whether byte beginning of an identifier (or keyword).
* 
* @param {Id.Buffer}  _source
* @param {Real}       _byte
*/ 
function KorutiiniBuilderScanner_IsBeginIdentifier(_source, _byte)
{
  return KorutiiniBuilderScanner_IsAlpha(_byte);
}