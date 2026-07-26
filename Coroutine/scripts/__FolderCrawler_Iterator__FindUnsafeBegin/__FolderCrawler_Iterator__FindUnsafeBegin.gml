

/**
* Uses file_find_* functions unsafely, therefore starts file finding,
* but doesn't close it. This allows splitting file finding into 
* several frames, but also assumes YOU don't use file_find_* functions
* elsewhere while this is still open!
* 
* @context __FolderCrawler_Iterator
* @param {String}                 _mask
* @param {Constant.FileAttribute} _attr
*/ 
function __FolderCrawler_Iterator__FindUnsafeBegin(_mask, _attr)
{
  self.nextName = file_find_first(_mask, _attr);
}