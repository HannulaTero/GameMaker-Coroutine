/// @desc 
//===========================================================
// 
#region START COROUTINE - Everything after is coroutine code.
/*
  
  Coroutine will modify file-structs of FolderCrawler.
  -> Mostly adds "buffer", "source", "hash", "cache"
    -> Buffer is loaded contents of the file.
    -> Source is buffer loaded as string.
    -> Hash is MD5 hash of the buffer.
    -> Cache is reference to other file.
  -> For keywords it also does "lines" & "tokens"
  
  
  Cache is stored in same folder with same name, expect with ".kocache"
  -> The cache hash-value is stored in first line as comment "// ..."
  
  
*/ 
#endregion
//
//===========================================================
// 
#region START COROUTINE - Everything after is coroutine code.


KORUTIINI
  name : "Korutiini Builder - Initialize",

ON_CANCEL
  show_debug_message("[Korutiini][Builder] Initialization has failed!");


BEGIN


#endregion
//
//===========================================================
// 
#region Preparations.


// Temporal context.
temp = { };


// The root folder, which is under inspection.
// -> Initialized with dummy one at start.
folderRoot = new FolderCrawler_Folder(undefined, "", "");


// What files are expected to be found.
// -> Initialized with dummy ones at start.
fileKeywords    = new FolderCrawler_File(undefined, "", "");
fileGenerated   = new FolderCrawler_File(undefined, "", "");
fileSources     = [ ];
fileValidCaches = [ ];


// Keyword-related.
// -> The prefix is what macros use at Korutiin-Sugar.
// -> Keyowrd user handles must be fetched.
keywordPrefix = "__KORUTIINISUGAR_KEYWORD__";
keywordLabels = __KorutiiniBuilder_KeywordsSugar();

keyword_KORUTIINI = "<undefined-keyword>";


// Get the command line parameters.
commandLine = new KorutiiniBuilder_CommandLine();


#endregion
//
//===========================================================
// 
#region Check whether path was given as batch-parameter.


pathRoot = undefined;
IF commandLine.Exists("--path") THEN
  pathRoot = commandLine.GetParam("--path");
END

  
#endregion
//
//===========================================================
// 
#region If no path, then request directly from the user.


IF (pathRoot == undefined) THEN
  ASYNC_REQUEST 
    DO_REQUEST 
      // The first parameter should be from GameMaker, filename and path.
      return get_string_async( "Give root-folder path", parameter_string(0) );
    ON_SUCCESS 
      pathRoot = async_load[? "result"];
    ON_FAILURE
      KorutiiniBuilder_Failure("No valid path was given.");
  ASYNC_END
  AWAIT_REQUESTS
END


#endregion
//
//===========================================================
// 
#region Start timing the building.


timeBegin = get_timer();


#endregion
//
//===========================================================
// 
#region Crawl through all files and folders within the path.


crawler = folder_crawl(pathRoot, { 
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
      case nameGenerated: fileGenerated = _file; return;
      case nameKeywords:  fileKeywords  = _file; return;
    }
    
    // Collect all GML files as sources.
    // -> Skip all Korutiini-library files.
    if (filename_ext(_file.name) == ".gml")
    && (string_pos("Korutiini", _file.name) == 0)
    {
      array_push(fileSources, _file);
      return;
    }
  }
});


// Wait until crawler has finished.
AWAIT crawler.IsFinished() PASS
folderRoot = crawler.GetRoot();


#endregion
//
//===========================================================
// 
#region Ensure expected files were found.


// If root has not changed, then they are still the dummy-files.
IF (fileKeywords.root == undefined) THEN
  KorutiiniBuilder_Failure("Could not find '.gml'-file for keyword-labels.");
END


IF (fileGenerated.root == undefined) THEN
  KorutiiniBuilder_Failure("Could not find '.gml'-file for generated content.");
END



#endregion
//
//===========================================================
// 
#region Read user-defined keyword -labels.


fileKeywords.source = "";
fileKeywords.buffer = buffer_create(1, buffer_grow, 1);

ASYNC_REQUEST 
  DO_REQUEST return buffer_load_async(
    fileKeywords.buffer, fileKeywords.path, 0, -1
  );
  ON_SUCCESS 
    fileKeywords.source = buffer_peek(fileKeywords.buffer, 0, buffer_text);
    buffer_delete(fileKeywords.buffer);
    
  ON_FAILURE 
    buffer_delete(fileKeywords.buffer);
    KorutiiniBuilder_Failure($"Loading keywords to buffer failed!");
    
ASYNC_END

AWAIT_REQUESTS 


#endregion
//
//===========================================================
// 
#region Split into lines, and then into tokens.


// Split into lines.
fileKeywords.lines  = string_split_ext(fileKeywords.source, [ "\n", "\r" ], true);
fileKeywords.tokens = array_create(array_length(fileKeywords.lines)); 


// Split into tokens
FOREACH key, value IN fileKeywords.lines THEN 
  static delimiters = [ " ", "\t" ];
  fileKeywords.tokens[key] = string_split_ext(value, delimiters, true);
END


#endregion
//
//===========================================================
// 
#region Iterate through each line and check for macro-definitions.


// Expects "#macro LABEL KEYWORD" -> three tokens.
FOREACH tokens : value IN fileKeywords.tokens THEN 
  
  // Skip over the non-macro-definitions.
  IF (array_length(tokens) < 3) || (tokens[0] != "#macro") THEN
    CONTINUE
  END
  
  // Store the label, if keyword definition exists.
  temp.keyword = string_replace(tokens[2], keywordPrefix, "");
  IF struct_exists(keywordLabels, temp.keyword) THEN
    keywordLabels[$ temp.keyword] = tokens[1];
  END
END


#endregion
//
//===========================================================
// 
#region Check whether there are missing keyword-labels.


temp.missing = [ ];


FOREACH keyword : key, label : value IN keywordLabels THEN
  IF (label == "") THEN
    array_push(temp.missing, keyword);
  END
END


IF (array_length(temp.missing) > 0) THEN
  KorutiiniBuilder_Failure($"Missing labels for keywords : {string_join_ext(", ", temp.missing)}");
END


#endregion
//
//===========================================================
// 
#region Inform which keywords have been found. Set convenience accessess.


show_debug_message("Found following labels for keywords: ");

FOREACH keyword : key, label : value IN keywordLabels THEN
  temp.count = string_length(keyword);
  temp.space = string_repeat(" ", 12 - temp.count);
  show_debug_message($">> {keyword}{temp.space} : {label}");
END


// For convenience.
keyword_KORUTIINI = keywordLabels[$ "KORUTIINI"];


#endregion
//
//===========================================================
// 
#region Load all source-files to RAM to deal with. 


// Load all files, tag to file-asset.
// Even if there is million lines of code, each line being taking 64 characters,
// that is should still be about 64MB of RAM usage. 
FOREACH file : value IN fileSources THEN

  file.source = "";
  file.buffer = buffer_create(1, buffer_grow, 1);
  
  // Read the file.
  ASYNC_REQUEST 
    DO_REQUEST return buffer_load_async(
      file.buffer, file.path, 0, -1
    );
    ON_FAILURE
      KorutiiniBuilder_Failure("Failed to load a source-file.");
      
  ASYNC_END
END


#endregion
//
//===========================================================
// 
#region Load all caches to RAM to deal with. 


FOREACH file : value IN fileSources THEN
  
  // Check whether cache exists.
  temp.cacheName = filename_change_ext(file.name, ".kocache");
  file.cache = file.root.files[$ temp.cacheName];
  
  // If doesn't have cache, skip it.
  IF (file.cache == undefined) THEN
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
#region Filter out all source-files with valid cached.


temp.recheck = [ ];
temp.helper  = buffer_create(32, buffer_fixed, 1);

FOREACH file : value IN fileSources THEN

  // Generate hash for file.
  // -> This is required anyways when comparing old cache, or creating new ones.
  file.hash = buffer_md5(file.buffer, 0, buffer_get_size(file.buffer));
  
  // Skip if doesn't have cache.
  IF file.cache == undefined THEN 
    array_push(temp.recheck, file);
    CONTINUE
  END
  
  // Get cache hash - stored in first line as comment.
  // This skips first 3 characters, which are comment "// ".
  buffer_copy(file.cache.buffer, 3, 32, temp.helper, 0);
  file.cache.hash = buffer_read(temp.helper, buffer_text);
  
  
  // Compare the hashes.
  // -> If has valid cache, then doesn't need to be processed.
  IF file.hash == file.cache.hash THEN
    array_push(fileValidCaches, file.cache);
    CONTINUE
  END
  
  
  // Otherwise cache is invalid.
  // -> Have to recheck file-contents.
  // -> Old cache can also be removed.
  array_push(temp.recheck, file);
  buffer_delete(file.cache.buffer);
  file_delete(file.cache.path);
END 


// Not needed anymore.
buffer_delete(temp.helper);
array_resize(fileSources, 0);


#endregion
//
//===========================================================
// 
#region Check the target files whether they use korutiini.


temp.sources = [ ];

FOREACH file : value IN temp.recheck THEN
  
  // Read out the contents.
  file.source = buffer_read(file.buffer, buffer_text);
  
  
  // Check whether file mentions korutiini anywhere.
  // -> This quick test doesn't consider strings or comments.
  IF string_pos(keyword_KORUTIINI, file.source) > 0 THEN 
    array_push(temp.sources, file);
    CONTINUE;
  END
  
  
  // Otherwise is not point of interest.
  buffer_delete(file.buffer);
  file.source = undefined;
END


// Not needed anymore.
array_resize(temp.recheck, 0);


#endregion
//
//===========================================================
// 
#region Extract parts of sources, which use korutiini.


// Preparations - trying to match korutiini-keyword.
temp.length = string_byte_length(keyword_KORUTIINI);
temp.helper = buffer_create(temp.length, buffer_fixed, 1);
buffer_poke(temp.helper, 0, buffer_text, keyword_KORUTIINI);
buffer_seek(temp.helper, buffer_seek_start, 0);


// Find proper parts, which use coroutine.
sources = [ ];
FOREACH file : value IN temp.sources THEN
  KorutiiniBuilder_FindKorutiiniUsages(sources, file, temp.helper);
END
AWAIT_SUBTASKS


// 


// Not needed anymore.
buffer_delete(temp.helper);
array_resize(temp.sources, 0);


#endregion
//
//===========================================================
// 
#region Finalization.


var _time = (get_timer() - timeBegin) / 1000;
show_debug_message($"[Korutiini][Builder] Finished! Time taken : {_time} ms");
game_end();


#endregion
//
//===========================================================
FINISH DISPATCH
//===========================================================