//==========================================================
//
#region INFORMATION.
/*

  This is naive sorting method, which is really inefficient.
  So should be used only for smallest sortable sets.
  Use mergesort or something else, if you have more items.

*/
#endregion
// 
//==========================================================
//
#region UNIFORMS & OTHER


precision highp float;

uniform vec2 uniShape;
uniform float uniOffset;
uniform float uniCount;


#endregion
// 
//==========================================================
//
#region FUNCTION DECLARATIONS.


float IDiv(float lhs, float rhs)
{
  return floor((lhs + 0.5) / rhs);
}

float IMod(float lhs, float rhs)
{
  return floor(lhs - IDiv(lhs, rhs) * rhs + 0.5);
}

float Permute(vec2 shape, vec2 pos) 
{
  return pos.x + pos.y * shape.x;
}


vec2 Permute(vec2 shape, float idx) 
{
  vec2 pos;
  pos.y = IDiv(idx, shape.x);
  pos.x = floor(idx - pos.y * shape.x + 0.5);
  return pos;
}

vec4 Sample(sampler2D tex, vec2 shape, vec2 pos)
{
  return texture2D(tex, (pos + 0.5) / shape); 
}


vec4 Sample(sampler2D tex, vec2 shape, float idx)
{
  return Sample(tex, shape, Permute(shape, idx));
}


#endregion
// 
//==========================================================
//
#region MAIN FUNCTION.


void main() 
{
  // Get the current index position.
  vec2 posTarget = floor(gl_FragCoord.xy);
  float idx = Permute(uniShape, posTarget);
  
  // Odd-even sorting.
  if (IMod(idx + uniOffset, 2.0) < 0.5) 
  {
    vec4 lhs = Sample(gm_BaseTexture, uniShape, idx);
    vec4 rhs = Sample(gm_BaseTexture, uniShape, min(idx + 1.0, uniCount - 1.0));
    gl_FragColor = (lhs.r <= rhs.r) ? lhs : rhs;
  } 
  else
  {
    vec4 lhs = Sample(gm_BaseTexture, uniShape, max(idx - 1.0, 0.0));
    vec4 rhs = Sample(gm_BaseTexture, uniShape, idx);
    gl_FragColor = (lhs.r <= rhs.r) ? rhs : lhs;
  }
}


#endregion
// 
//==========================================================