#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif


// rendering params
const float sphsize = 0.8; // planet size
const float dist = 0.08; // distance for glow and distortion
const float perturb = 0.3;// distortion amount of the flow around the planet
const float windspeed = 0.25; // speed of wind flow
const float glow = 3.2; // glow amount, mainly on hit side

const float start = 118.0;
const float steps = 194.0; // number of steps for the volumetric rendering
const float stepsize = 0.01; 
const float brightness = 1.0;

float wind(vec3 p) {
  float d = max(0.0, dist - max(0.0, length(p) - sphsize) / sphsize) / dist; // for distortion and glow area
  float x = max(0.5, p.x * -2.); // to increase glow on left side
  return length(p) * (d * glow * x)+ d * glow * x; // return the result with glow applied
}

varying vec4 vertColor;

void main() {
  gl_FragColor = vertColor 
    + abs(sin(gl_FragCoord.z/8.0)) / 2.0 
    + abs(sin(gl_FragCoord.y/9.0)) / 2.0 ;
}
