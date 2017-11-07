#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

void main() {
    vec2 st = gl_FragCoord.xy/u_resolution.xy;
    vec3 color = vec3(0.0);

    vec2 pos = vec2(0.5)-st/(sin(u_time)+1.0)/(cos(u_time*0.89)/2.0+1.0);

    float r = length(pos)*2.0 * sin(u_time)*1.2;
    float a = atan(pos.x,pos.y)+u_time;

    float f = cos(a*3.);
    f = abs(cos(a*3.));
    f = abs(cos(a*2.5))*.5+.3;
    f = abs(cos(a*12.)*sin(a*3.))*.8+0.01;
    // f = smoothstep(-.2,0.1, tan(a*10.))*0.2+0.5;

    color = vec3( 
        1.-smoothstep(f+0.1,f+1.11,r-sin(u_time*0.2)*0.001),
        1.-smoothstep(f+2.2,f+1.02,r+sin(u_time*1.0)*0.01),
        1.0-smoothstep(0.2,f+0.02,r+sin(u_time*1.2)*0.02)
       );

    gl_FragColor = vec4(color, 1.0);
}
