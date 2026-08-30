

/**
* 
* @param {Array}                      _target   Results are pushed here.
* @param {Struct.FolderCrawler_File}  _file     Modified FC-File, containing buffer etc.
* @param {Id.Buffer}                  _helper   Contains bytes to match KORUTIINI-keyword.
* @ignore
*/ 
function KorutiiniBuilder_FindKorutiiniUsages(_target, _file, _helper)
{
static prototype = KORUTIINI BEGIN 
  
  // Iterate through whole buffer.
  buffer_seek(file.buffer, buffer_seek_start, 0);
  WHILE buffer_tell(file.buffer) < buffer_get_size(file.buffer) THEN
    char = buffer_read(file.buffer, buffer_u8);
    
    
    // Handle single-line strings.
    IF char == ord("\"") THEN 
      WHILE 
        buffer_tell(file.buffer) < buffer_get_size(file.buffer) && 
        buffer_read(file.buffer, buffer_u8) != ord("\"") 
      THEN END
      CONTINUE
    END
    
    
    // Handle comments.
    IF char == ord("/") THEN 
      peek = buffer_peek(file.buffer, buffer_tell(file.buffer) + 1, buffer_u8);
        
      // Single-line comment.
      IF peek == ord("/") THEN 
        WHILE 
          buffer_tell(file.buffer) < buffer_get_size(file.buffer) && 
          buffer_read(file.buffer, buffer_u8) != ord("\n") 
        THEN END
      END
        
      // Multi-line comment.
      IF peek == ord("*") THEN 
        char = buffer_read(file.buffer, buffer_u8);
        WHILE buffer_tell(file.buffer) < buffer_get_size(file.buffer) THEN
          prev = char;
          char = buffer_read(file.buffer, buffer_u8);
          IF prev == ord("*") && char == ord("/") THEN 
            BREAK
          END
        END
      END
      
      CONTINUE
    END
    
    
    // Otherwise check whether matches.
    buffer_seek(helper, buffer_seek_start, 0); 
    WHILE 
      buffer_tell(file.buffer) < buffer_get_size(file.buffer) && 
      buffer_tell(helper) < buffer_get_size(helper) && 
      buffer_read(helper, buffer_u8) == buffer_read(file.buffer, buffer_u8)
    THEN END
    
    // DEBUG if matched partially.
    IF buffer_tell(helper) > 3 THEN
      show_debug_message($"Match partially: {buffer_tell(helper)}");
    END
    
    // If matched in full.
    IF buffer_tell(helper) == buffer_get_size(helper) THEN
      show_debug_message($"Found a match! {buffer_tell(file.buffer)}");
    END
    
  END
  
FINISH
  
  
  // Dispatch new coroutine-task.
  return prototype.Dispatch(self, {
    target  : _target,
    file    : _file,
    helper  : _helper
  });
}