uniform mat4 transform;
uniform mat3 normalMatrix;
uniform vec3 lightNormal;

attribute vec4 position;
attribute vec4 color;
attribute vec3 normal;

varying vec4 vertColor;
varying vec3 vertNormal;
varying vec3 vertLightDir;
/* uniform vec2 resolution; */

void main() {
  gl_Position = transform * position;
  vertNormal = normalize(normalMatrix * normal);
  vertLightDir = -lightNormal;
  vertColor = vec4(vertNormal,1.0);
}
