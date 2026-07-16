

enum CoroutineCode
{
  OP_ERROR,
  OP_FINISH,
  OP_STMT,
  OP_HALT,
  OP_SET,
  OP_AWAIT,
  OP_length,
};

enum CoroutineHalt
{
  OP_ERROR,
  OP_YIELD,
  OP_DELAY,
  OP_PAUSE,
  OP_length,
};

enum CoroutineAwait
{
  OP_ERROR,
  OP_COND,
  OP_SUBTASKS,
  OP_REQUESTS,
  OP_LISTENERS,
  OP_TASK,
  OP_BROADCAST,
  OP_length,
};



function CoroutineCompiler() constructor
{
  
  
  
  static Dispatch = function()
  {
    
  };
  
  
  static Compile = function(_node)
  {
    
  };
  
  
  static functors = coroutine_mapping([
    
    ["FINISH"],
    function(_node)
    {
      array_push(code, CoroutineCode.OP_FINISH);
    },
    
    
    ["BLOCK"],
    function(_block)
    {
      var _nodes = _block.nodes;
      var _count = array_length(_nodes);
      for(var i = _count-1; i >= 0; i--)
      {
        Compile(_nodes[i]);
      }
    },
    
    
    ["STMT"],
    function(_node)
    {
      array_push(code, CoroutineCode.OP_STMT, _node.call);
    },
    
    
    // Labels for goto -targets.
    // Doesn't produce new node, only marks position.
    ["LABEL"],
    function(_node)
    {
      labels[$ _node.label] = array_length(code);
    },
    
    
    ["YIELD"],
    function(_node)
    {
      array_push(code, CoroutineCode.OP_HALT, CoroutineHalt.OP_YIELD);
    },
    
    
    ["PAUSE"],
    function(_node)
    {
      array_push(code, CoroutineCode.OP_HALT, CoroutineHalt.OP_PAUSE);
    },
    
    
    ["SET"],
    function(_node)
    {
      array_push(code, CoroutineCode.OP_SET, _node.call);
    },
    
    
    ["YIELD_SET"],
    function(_node)
    {
      array_push(code, 
        CoroutineCode.OP_HALT, CoroutineHalt.OP_YIELD,
        CoroutineCode.OP_SET, _node.call
      );
    },
    
    
    ["PAUSE_SET"],
    function(_node)
    {
      array_push(code, 
        CoroutineCode.OP_HALT, CoroutineHalt.OP_PAUSE,
        CoroutineCode.OP_SET, _node.call
      );
    },
    
    
    ["DELAY"],
    function(_node)
    {
      // Cases for different delay-types.
      static rates = coroutine_mapping([
        ["MICROS"], function() { return 1_000_000.0; }, 
        ["MILLIS"], function() { return 1_000.0; }, 
        ["FRAMES"], function() { return 1.0; }, 
        ["SECONDS"], function() { return 1.0; }, 
      ]);
      
      static units = coroutine_mapping([
        ["MICROS"], function() { return time_source_units_seconds; }, 
        ["MILLIS"], function() { return time_source_units_seconds; }, 
        ["FRAMES"], function() { return time_source_units_frames; }, 
        ["SECONDS"], function() { return time_source_units_seconds; }, 
      ]);
      
      array_push(code, 
        CoroutineCode.OP_HALT, CoroutineHalt.OP_DELAY,
        _node.call, rates[$ _node.type](), units[$ _node.type]()
      );
    },
    
    
    ["AWAIT"],
    function(_node)
    {
      array_push(code, CoroutineCode.OP_AWAIT, CoroutineAwait.OP_COND, _node.call);
    },
    
    
    ["AWAIT_ASYNC", "AWAIT_COROUTINE"],
    function(_node)
    {
      array_push(code, CoroutineCode.OP_AWAIT, CoroutineAwait.OP_TASK, _node.call);
    },
    
    
    ["AWAIT_BROADCAST"],
    function(_node)
    {
      array_push(code, CoroutineCode.OP_AWAIT, CoroutineAwait.OP_SUBTASKS);
    },
    
    
    ["AWAIT_SUBTASKS"],
    function(_node)
    {
      array_push(code, CoroutineCode.OP_AWAIT, CoroutineAwait.OP_SUBTASKS);
    },
    
    
    ["AWAIT_REQUESTS"],
    function(_node)
    {
      array_push(code, CoroutineCode.OP_AWAIT, CoroutineAwait.OP_REQUESTS);
    },
    
    
    ["AWAIT_LISTENERS"],
    function(_node)
    {
      array_push(code, CoroutineCode.OP_AWAIT, CoroutineAwait.OP_LISTENERS);
    },
    
    
  ]);
  
  
}













  
