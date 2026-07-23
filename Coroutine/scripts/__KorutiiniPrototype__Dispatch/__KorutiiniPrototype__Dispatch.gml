
/**
* Creates new active task of prototype.
*
* @context __KorutiiniPrototype
* @param {Id.Instance | Struct} _this
* @param {Struct}               _vars
*/ 
function __KorutiiniPrototype__Dispatch(_this=other, _vars=undefined)
{
  return new __KorutiiniTask(self, _this, _vars); 
}