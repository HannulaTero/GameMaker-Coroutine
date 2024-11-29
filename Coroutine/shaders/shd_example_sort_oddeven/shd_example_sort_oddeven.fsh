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

uniform vec2 uniLayout;
uniform float uniOffset;
uniform float uniCount;


#endregion
// 
//==========================================================
//
#region FUNCTION DECLARATIONS.


float iDiv(float lhs, float rhs);
float iMod(float lhs, float rhs);

float Permute(vec2 layout, vec2 pos);
vec2 Permute(vec2 layout, float index);

vec4 Sample(sampler2D tex, vec2 layout, vec2 pos);
vec4 Sample(sampler2D tex, vec2 layout, float index);


#endregion
// 
//==========================================================
//
#region MAIN FUNCTION.


void main() 
{
  // Get the current index position.
  vec2 posTarget = floor(gl_FragCoord.xy);
  float index = Permute(uniLayout, posTarget);
  
  // Odd-even sorting.
  if (iMod(index + uniOffset, 2.0) < 0.5) 
  {
    vec4 lhs = Sample(gm_BaseTexture, uniLayout, index);
    vec4 rhs = Sample(gm_BaseTexture, uniLayout, min(index + 1.0, uniCount - 1.0));
    gl_FragData[0] = (lhs.r <= rhs.r) ? lhs : rhs;
  } 
  else
  {
    vec4 lhs = Sample(gm_BaseTexture, uniLayout, max(index - 1.0, 0.0));
    vec4 rhs = Sample(gm_BaseTexture, uniLayout, index);
    gl_FragData[0] = (lhs.r <= rhs.r) ? rhs : lhs;
  }
}


#endregion
// 
//==========================================================
//
#region FUNCTION DEFINITIONS.


float iDiv(float lhs, float rhs)
{
  return floor((lhs + 0.5) / rhs);
}

float iMod(float lhs, float rhs)
{
  return floor(lhs - iDiv(lhs, rhs) * rhs + 0.5);
}

float Permute(vec2 layout, vec2 pos) 
{
  return pos.x + pos.y * layout.x;
}


vec2 Permute(vec2 layout, float index) 
{
  vec2 pos;
  pos.y = iDiv(index, layout.x);
  pos.x = floor(index - pos.y * layout.x + 0.5);
  return pos;
}

vec4 Sample(sampler2D tex, vec2 layout, vec2 pos)
{
  return texture2D(tex, (pos + 0.5) / layout); 
}


vec4 Sample(sampler2D tex, vec2 layout, float index)
{
  return Sample(tex, layout, Permute(layout, index));
}


#endregion
// 
//==========================================================