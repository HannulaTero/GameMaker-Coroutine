/// @desc IF-ELIF-ELSE.



KORUTIINI BEGIN

  IF choose(true, false) THEN
    KorutiiniExample_Log("THEN-branch");
    
  ELIF choose(true, false) THEN
    KorutiiniExample_Log("ELIF[0]-branch");
    
  ELIF choose(true, false) THEN
    KorutiiniExample_Log("ELIF[1]-branch");
    
  ELIF choose(true, false) THEN
    KorutiiniExample_Log("ELIF[2]-branch");
    
  ELIF choose(true, false) THEN
    KorutiiniExample_Log("ELIF[3]-branch");
    
  ELSE
    KorutiiniExample_Log("ELSE-branch");
    
  END

FINISH DISPATCH