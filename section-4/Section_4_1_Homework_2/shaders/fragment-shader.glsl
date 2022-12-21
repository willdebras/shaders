
varying vec2 vUvs;

uniform sampler2D diffuse;
uniform sampler2D overlay;
uniform vec4 tint;


void main(void) {
  vec4 diffuseSample = texture2D(diffuse, vUvs);

  gl_FragColor = smoothstep(vec4(0.0), vec4(1.0), diffuseSample);
}