

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
  */ 
  static GetIndex = function(_name)
  {
    return self.parameters[$ _name];
  };
  
  
  /**
  */ 
  GetParam = function(_name)
  {
    return parameter_string(self.parameters[$ _name] + 1);
  };
  
  
  /**
  */ 
  Exists = function(_name)
  {
    return struct_exists(self.parameters, _name);
  };
}