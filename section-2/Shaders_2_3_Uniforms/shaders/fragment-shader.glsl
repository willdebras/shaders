
varying vec2 vUvs;
varying vec3 vColour;

uniform vec4 colour1;
uniform vec4 colour2;

void main() {
  gl_FragColor = vec4(vColour, 1.0);
}