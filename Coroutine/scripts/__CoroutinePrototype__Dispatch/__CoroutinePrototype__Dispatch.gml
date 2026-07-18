
/**
* Creates new active task of prototype.
*
* @context __CoroutinePrototype
* @param {Id.Instance | Struct} _this
* @param {Struct}               _vars
*/ 
function __CoroutinePrototype__Dispatch(_this=other, _vars=undefined)
{
  return new __CoroutineTask(self, _this, _vars); 
}