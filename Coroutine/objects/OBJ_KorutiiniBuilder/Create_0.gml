/// @desc 
/*

*/ 
//===========================================================
// 
#region Preparations.


// The root folder, which is under inspection.
self.root = new FolderCrawler_Folder(undefined, "", "");


// What files are expected to be found.
self.file = {
  keywords  : new FolderCrawler_Folder(undefined, "", ""),
  generated : new FolderCrawler_Folder(undefined, "", ""),
  sources   : [ ],
  cached    : [ ],
};


// Get the command line parameters.
self.commandLine = new KorutiiniBuilder_CommandLine();


// Keyword-related.
self.keyword = {
  prefix : "__KORUTIINISUGAR_KEYWORD__",
  labels : __KorutiiniBuilder_KeywordsSugar()
}


#endregion
//
//===========================================================
// 
#region Methods.


self.Failed = function(_message)
{
  show_debug_message($"[Korutiini][Builder] {_message}");
  self.korutiini.Cancel();
  instance_destroy();
};


#endregion
//
//===========================================================
// 
#region Start the coroutine.


self.korutiini = KORUTIINI
  name : "Korutiini Builder",
  desc : @"
    This crawls through root-path, finds assets using korutiini, 
    parses them and resolves locals, then generates the executable code.
    This only edits single project-file (__KorutiiniSugar_GENERATED).
  "

ON_CANCEL
  show_debug_message("[Korutiini][Builder] Building has failed!");


BEGIN
//===========================================================
// 
#region Preparations.


// Where temporal data is stored.
temp = { };


#endregion
//
//===========================================================
// 
#region Check whether path was given as batch-parameter.


path = undefined;
IF this.commandLine.Exists("--path") THEN
  path = this.commandLine.GetParam("--path");
END

  
#endregion
//
//===========================================================
// 
#region If no path, then request directly from the user.


IF (path == undefined) THEN
  ASYNC_REQUEST 
    DO_REQUEST 
      // The first parameter should be from GameMaker, filename and path.
      return get_string_async( "Give root-folder path", parameter_string(0) );
    ON_SUCCESS 
      path = async_load[? "result"];
    ON_FAILURE
      this.Failed("No valid path was given.");
  ASYNC_END
  AWAIT_REQUESTS
END


#endregion
//
//===========================================================
// 
#region Crawl through all files and folders within the path.


// Dispatch the crawler.
crawler = folder_crawl(path, { 
  unsafe : true,
  context : { },
  
  // Operate on each file, find ones which are point of interest.
  file : function(_file, _context)
  {
    // Few library related files what needs to be found.
    static nameGenerated  = nameof(__KorutiiniSugar_GENERATED) + ".gml";
    static nameKeywords   = nameof(KorutiiniSugar_Keywords) + ".gml";
    
    // Check whether one of items being searched.
    switch(_file.name)
    {
      case nameGenerated: this.file.generated = _file; return;
      case nameKeywords:  this.file.keywords  = _file; return;
    }
    
    // Collect all GML files as sources.
    // -> Skip all Korutiini-library files.
    if (filename_ext(_file.name) == ".gml")
    && (string_pos("Korutiini", _file.name) == 0)
    {
      array_push(this.file.sources, _file);
      return;
    }
  }
});


// Wait until crawler has finished.
AWAIT crawler.IsFinished() PASS
this.root = crawler.GetRoot();


#endregion
//
//===========================================================
// 
#region Ensure files for keyword-labels and generation target have been found.


IF (this.file.keywords.root == undefined) THEN
  this.Failed("Could not find '.gml'-file for keyword-labels.");
  CANCEL;
END


IF (this.file.generated.root == undefined) THEN
  this.Failed("Could not find '.gml'-file for generated content.");
  CANCEL;
END
  
  
#endregion
//
//===========================================================
// 
#region Read keyword -labels.


sourceKeywords = "";
buffer = buffer_create(1, buffer_grow, 1);
ASYNC_REQUEST 
  DO_REQUEST return buffer_load_async(
    buffer, this.file.keywords.path, 0, -1
  );
  ON_SUCCESS 
    sourceKeywords = buffer_peek(buffer, 0, buffer_text);
    buffer_delete(buffer);
    
  ON_FAILURE 
    buffer_delete(buffer);
    this.Failed($"Loading keywords to buffer failed!");
    
ASYNC_END
AWAIT_REQUESTS


#endregion
//
//===========================================================
// 
#region Split into lines and then into tokens.


lines = string_split_ext(sourceKeywords, [ "\n", "\r" ], true);
FOREACH key, value IN lines THEN 
  static delimiters = [ " ", "\t" ];
  lines[key] = string_split_ext(value, delimiters, true);
END


#endregion
//
//===========================================================
// 
#region Iterate through each line and check for macro-definitions.


// Expects "#macro LABEL KEYWORD" 
// -> There are three tokens.
FOREACH tokens : value IN lines THEN 
  
  // Skip over the non-macro-definitions.
  IF (array_length(tokens) < 3) || (tokens[0] != "#macro") THEN
    CONTINUE
  END
  
  // Store the label, if keyword definition exists.
  keyword = string_replace(tokens[2], this.keyword.prefix, "");
  IF struct_exists(this.keyword.labels, keyword) THEN
    this.keyword.labels[$ keyword] = tokens[1];
  END
END


#endregion
//
//===========================================================
// 
#region Check whether there are missing keyword-labels.


missing = [ ];
FOREACH keyword : key, label : value IN this.keyword.labels THEN
  IF (label == "") THEN
    array_push(missing, keyword);
  END
END


IF (array_length(missing) > 0) THEN
  keywords = string_join_ext(", ", missing);
  this.Failed($"Missing labels for keywords : {keywords}");
  CANCEL;
END


#endregion
//
//===========================================================
// 
#region Inform which keywords have been found.


show_debug_message("Found following labels for keywords: ");
FOREACH keyword : key, label : value IN this.keyword.labels THEN
  whitespace = string_repeat(" ", 12 - string_length(keyword));
  show_debug_message($">> {keyword}{whitespace} : {label}");
END
  
  
#endregion
//
//===========================================================
// 
#region Check caches and remove dirty ones.


recheck = [ ];
FOREACH file : value IN this.file.sources THEN
  
  // Check whether there exists cache.
  cacheName = filename_change_ext(file.name, ".kocache");
  cacheFile = file.root.files[$ cacheName];
  IF (cacheFile == undefined) THEN
    // Cache doesn't exist, push to be rechecked.
    array_push(recheck, file);
    CONTINUE;
  END
  
  
  // Get cache hash - stored in first line as comment.
  cacheOpen = file_text_open_read(cacheFile.path);
  cacheHash = file_text_readln(cacheOpen);
  cacheHash = string_delete(cacheHash, 1, 3); // Remove "// "
  file_text_close(cacheOpen);
  PASS
  
  
  // Compare the hashes - if matches, use cached file.
  fileHash = md5_file(file.path);
  IF (fileHash == cacheHash) THEN 
    array_push(this.file.cached, cacheFile);
    CONTINUE;
  END
  
  
  // Otherwise invalidate the cache, and push file to be processed.
  // -> Store the hash-value, so new cache can use it.
  file_delete(cacheFile.path);
  array_push(recheck, file);
  file.hash = fileHash;
  
END


#endregion
//
//===========================================================
// 
#region Check the target files whether they use korutiini.


array_resize(this.file.sources, 0);
FOREACH file : value IN recheck THEN
  
  // Read the file.
  source = "";
  buffer = buffer_create(1, buffer_grow, 1);
  ASYNC_REQUEST 
    DO_REQUEST return buffer_load_async(
      buffer, file.path, 0, -1
    );
    ON_SUCCESS 
      source = buffer_peek(buffer, 0, buffer_text);
      buffer_delete(buffer);
    
    ON_FAILURE 
      buffer_delete(buffer);
      this.Failed($"Loading keywords to buffer failed!");
    
  ASYNC_END
  AWAIT_REQUESTS
  
  
  // Check whether file mentions korutiini anywhere.
  // -> This quick test doesn't consider strings or comments.
  position = string_pos(this.keyword.labels[$ "KORUTIINI"], source);
  IF (position != 0) THEN 
    array_push(this.file.sources, file);
    file.content = source;
  END
  
END


#endregion
//
//===========================================================
// 
#region Extract parts of sources, which use korutiini.


FOREACH file : value IN this.file.sources THEN
  
  
END


#endregion
//
//===========================================================
// 
#region Finalization.
  
  
show_debug_message($"Time taken : {get_timer() / 1000} ms");
DELAY 1.0 SECONDS
game_end();


#endregion
//
//===========================================================
FINISH DISPATCH
//===========================================================