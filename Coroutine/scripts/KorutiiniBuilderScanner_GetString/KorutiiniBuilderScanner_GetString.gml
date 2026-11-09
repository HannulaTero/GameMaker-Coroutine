

/**
* Get string, selects best option to continue.
* Assumes that ends in valid string, as otherwise GML compiler 
* would not let game to compile. And this tokenizer works as preproc.
* 
*/ 
function KorutiiniBuilderScanner_GetString(_tokens, _source)
{
  var _tellBegin = buffer_tell(_source);
  var _byte = buffer_peek(_source, _tellBegin, buffer_u8);
  
  switch(_byte)
  {
    case ord("\""): return KorutiiniBuilderScanner_GetStringSingle(_tokens, _source);
    case ord("@"):  return KorutiiniBuilderScanner_GetStringMulti(_tokens, _source);
    case ord("$"):  return KorutiiniBuilderScanner_GetStringTemplate(_tokens, _source);
  }
}


