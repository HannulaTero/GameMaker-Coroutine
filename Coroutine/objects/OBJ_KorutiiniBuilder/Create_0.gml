/// @desc 
/*

*/ 
//===========================================================
// 
#region Preparations.


// The root folder, which is under inspection.
// -> Initialized with dummy one at start.
self.root = new FolderCrawler_Folder(undefined, "", "");


// What files are expected to be found.
// -> Initialized with dummy ones at start.
self.file = {
  keywords  : new FolderCrawler_Folder(undefined, "", ""),
  generated : new FolderCrawler_Folder(undefined, "", ""),
  sources   : [ ],
  cached    : [ ],
};


// Get the command line parameters.
self.commandLine = new KorutiiniBuilder_CommandLine();


// Keyword-related.
// -> The prefix is what macros use at Korutiin-Sugar.
// -> Keyowrd user handles must be fetched.
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
#region START COROUTINE - Everything after is coroutine code.


self.korutiini = KORUTIINI
  name : "Korutiini Builder",
  desc : (@"
    This crawls through root-path, finds assets using korutiini, 
    parses them and resolves locals, then generates the executable code.
    This only edits single project-file (__KorutiiniSugar_GENERATED).
  ")

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


timeBegin = get_timer();


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
#region Read user-defined keyword -labels.


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
#region Load all source-files to RAM to deal with. 


// Load all files, tag to file-asset.
// Even if there is million lines of code, each line being taking 64 characters,
// that is should still be about 64MB of RAM usage. 
FOREACH file : value IN this.file.sources THEN

  file.source = "";
  file.buffer = buffer_create(1, buffer_grow, 1);
  
  // Read the file.
  ASYNC_REQUEST 
    DO_REQUEST return buffer_load_async(
      file.buffer, file.path, 0, -1
    );
    ON_FAILURE
      this.Failed("Failed to load a source-file.");
      
  ASYNC_END
END


#endregion
//
//===========================================================
// 
#region Load all caches to RAM to deal with. 


FOREACH file : value IN this.file.sources THEN
  
  // Check whether cache exists.
  file.cache = { };
  file.cache.name = filename_change_ext(file.name, ".kocache");
  file.cache.file = file.root.files[$ file.cache.name];
  
  // If doesn't have cache, skip it..
  IF (file.cache.file == undefined) THEN
    file.cache = undefined;
    CONTINUE;
  END
  
  // Otherwise load the cahce.
  file.cache.source = "";
  file.cache.buffer = buffer_create(1, buffer_grow, 1);
  
  ASYNC_REQUEST 
    DO_REQUEST return buffer_load_async(
      file.cache.buffer, file.cache.path, 0, -1
    );
  ASYNC_END
END


#endregion
//
//===========================================================
// 
#region Wait everything to load into RAM.


AWAIT_REQUESTS

  
#endregion
//
//===========================================================
// 
#region Filter out all cached.


recheck = [ ];
helper  = buffer_create(32, buffer_fixed, 1);
FOREACH file : value IN this.file.sources THEN

  // Generate hash for file.
  // -> This is required anyways when comparing old cache, or creating new ones.
  file.hash = buffer_md5(file.buffer, 0, buffer_get_size(file.buffer));
  
  // Skip if doesn't have cache.
  IF file.cache == undefined THEN 
    array_push(recheck, file);
    CONTINUE
  END
  
  // Get cache hash - stored in first line as comment.
  // This skips first 3 characters, which are comment "// ".
  buffer_copy(file.cache.buffer, 3, 32, helper, 0);
  file.cache.hash = buffer_read(helper, buffer_text);
  
  
  // Compare the hashes.
  // -> Have to recheck file-contents if cache doesn't match.
  // -> Then cache can also be removed.
  IF file.hash != file.cache.hash THEN
    array_push(recheck, file);
    buffer_delete(file.cache.buffer);
    file_delete(file.cache.path);
    CONTINUE
  END
  
END 


// Not needed anymore.
buffer_delete(helper);


#endregion
//
//===========================================================
// 
#region Check the target files whether they use korutiini.


array_resize(this.file.sources, 0);
keywordKorutiini = this.keyword.labels[$ "KORUTIINI"];
FOREACH file : value IN recheck THEN
  
  // Read out the contents.
  file.source = buffer_read(file.buffer, buffer_text);
  
  
  // Check whether file mentions korutiini anywhere.
  // -> This quick test doesn't consider strings or comments.
  IF string_pos(keywordKorutiini, file.source) > 0 THEN 
    array_push(this.file.sources, file);
  ELSE
    // Otherwise is not point of interest.
    buffer_delete(file.buffer);
    file.source = undefined;
  END
  
END


// Not needed anymore.
array_resize(recheck, 0);


#endregion
//
//===========================================================
// 
#region Extract parts of sources, which use korutiini.


FOREACH file : value IN this.file.sources THEN
  file.source = file.source;
  
END


#endregion
//
//===========================================================
// 
#region Finalization.
  
  
show_debug_message($"Time taken : {(get_timer() - timeBegin) / 1000} ms");
DELAY 1.0 SECONDS
game_end();


#endregion
//
//===========================================================
FINISH DISPATCH
//===========================================================