

/**
* Scans the source into stream of tokens.
* 
* Returns buffer with tokens embedded as [ U16, U16, U32, U32 ]
* - U16 Token-type
* - U16 Token-data
* - U32 Token start-position in the source.
* - U32 Token end-position in the source.
* 
* @param {Struct.FolderCrawler_File}  _file     Modified FolderCrawlerFile-struct, containing keys for buffer etc. 
* @returns {Id.Buffer}
*/ 
function KorutiiniBuilderScanner(_file)
{
// Define reusable coroutine.
static prototype = KORUTIINI BEGIN 
  
  
  // Iterate through whole buffer.
  buffer_seek(file.buffer, buffer_seek_start, 0);
  WHILE buffer_tell(file.buffer) < buffer_get_size(file.buffer) THEN
    KorutiiniBuilderScanner_SkipWhiteSpace(file.tokens, file.buffer);
    
    char = buffer_read(file.buffer, buffer_u8);
    
    IF KorutiiniBuilderScanner_IsBeginIdentifier(file.buffer, char) THEN 
      KorutiiniBuilderScanner_GetIdentifier(file.tokens, file.buffer);
      
    ELIF KorutiiniBuilderScanner_IsBeginNumber(file.buffer, char) THEN 
      KorutiiniBuilderScanner_GetNumber(file.tokens, file.buffer);
      
    ELIF KorutiiniBuilderScanner_IsBeginOperator(file.buffer, char) THEN 
      KorutiiniBuilderScanner_GetOperator(file.tokens, file.buffer);
      
    ELIF KorutiiniBuilderScanner_IsBeginString(file.buffer, char) THEN 
      KorutiiniBuilderScanner_GetString(file.tokens, file.buffer);
      
    ELSE
      // ...
    END
    
  END
  
  // Add the End Of File -token.
  KorutiiniBuilderScanner_AddEOF(file.tokens, file.buffer);
  
FINISH
  
  
  // Dispatch new coroutine-task.
  return prototype.Dispatch(self, {
    file : _file,
  });
}

