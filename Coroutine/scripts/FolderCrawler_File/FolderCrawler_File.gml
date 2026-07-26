


/**
* Creates struct, which holds file path and name.
* 
* @param {Struct.FolderCrawler_Folder | Undefined} _root
* @param {String} _name
* @param {String} _path
*/
function FolderCrawler_File(_root, _name, _path) constructor
{
  // The construct type.
  self.type = "file";
  
  
  // The root folder.
  self.root = _root;
  
  
  // The file name, including the extension.
  self.name = _name;
  
  
  // Absolute path, including the name.
  self.path = _path;
}