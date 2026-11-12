

/**
* Finds all parameters, and labels them.
*/ 
function KorutiiniBuilder_CommandLine() constructor
{
  self.parameters = { };
  
  
  for(var i = 0; i < parameter_count(); i++)
  {
    self.parameters[$ parameter_string(i)] = i;
  }
  
  
  /**
  * Returns parameter-index for given name.
  */ 
  static GetIndex = function(_name)
  {
    return self.parameters[$ _name];
  };
  
  
  /**
  * Returns argument for given parameter-name.
  */ 
  static GetParam = function(_name, _argNumber=0)
  {
    return parameter_string(self.parameters[$ _name] + _argNumber + 1);
  };
  
  
  /**
  * Returns whether parameter exists.
  */ 
  static Exists = function(_name)
  {
    return struct_exists(self.parameters, _name);
  };
}