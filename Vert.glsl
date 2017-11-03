uniform mat4 transform;
uniform mat3 normalMatrix;
uniform vec3 lightNormal;

attribute vec4 position;
attribute vec4 color;
attribute vec3 normal;

varying vec4 vertColor;
varying vec3 vertNormal;
varying vec3 vertLightDir;

void main() {
  gl_Position = transform * position;
  vertNormal = normalize(normalMatrix * normal);
  vertLightDir = -lightNormal;
  vertColor = color * vec4(gl_Position.x/500.0 + 0.5,
          gl_Position.y/10.0 + 0.0,
          gl_Position.y/500.0 + 0.5, 1.0);
}
