#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif


float rand(vec2 co){
  return fract(tan(dot(co.xy ,vec2(12.1898,18.233))) * 14358.5423);
}

vec3 filmicToneMapping(vec3 color) {
    color = max(vec3(0.), color - vec3(0.004));
    color = (color * (6.2 * color + .5)) / (color * (6.2 * color + 1.7) + 0.06);
    return color;
}


varying vec4 vertColor;
uniform vec2 resolution;


float getColor(float d, float rad, float t, float offset) {
    
    float v = 0.0;
    for(int i = 1; i < 10; i++) {
        v += (sin(rad * float(i) + t / pow(float(i), 2.0) + float(i) + offset) * 0.5 + 0.5) * pow(0.5, float(i));
    }
    v = 1.0 - smoothstep(v, v + 0.27, d);
    return v;
}


void main() {
    vec2 pos = gl_FragCoord.xy / resolution.xy;
    vec3 light = normalize(vec3(1.0));
    vec2 uv = ( gl_FragCoord.xy / resolution.x);
    vec3 col = vec3(0.1);

    col = vec3(sqrt(dot(col,vec3(uv,0.0))) / 2.0);

    gl_FragColor = vec4(filmicToneMapping(vec3(rand(pos*2.0),rand(pos),rand(pos*1.3))),1.0);
}
