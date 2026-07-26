

/**
* Adds given name as file unquestionable to the current folder.
* The iteration loop should ensure given name only is file,
* this can be achieven with attributes.
* 
* @context __FolderCrawler_Iterator
* @param {String} _name
*/ 
function __FolderCrawler_Iterator__File(_name)
{
  // Create new file for given path.
  var _path = (self.folderCurrent.path + "\\" + _name);
  var _file = new FolderCrawler_File(self.folderCurrent, _name, _path);
  self.ActionFile(_file, self.userContext);
  self.debugCountFiles += 1;
  
  // Add into the files of current folder.
  self.folderCurrent.files[$ _name] = _file;
  
  // Inform this being a file for second pass.
  self.fileMapping[? _name] = _file;
}


