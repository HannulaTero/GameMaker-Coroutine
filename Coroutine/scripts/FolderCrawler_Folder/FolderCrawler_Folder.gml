


/**
* Creates struct, which holds folder path and name, and references to underlying folders and files.
* 
* @param {Struct.FolderCrawler_Folder | Undefined} _root
* @param {String} _name
* @param {String} _path
*/
function FolderCrawler_Folder(_root, _name, _path) constructor
{
  // The construct type.
  self.type = "folder";
  
  
  // The root folder.
  self.root = _root;
  
  
  // Folder name.
  self.name = _name;
  
  
  // Absolute path, including the name.
  self.path = _path;
  
  
  // Holds file-constructs.
  self.files = { };
  
  
  // Holds other folders-constructs.
  self.folders = { };
}
