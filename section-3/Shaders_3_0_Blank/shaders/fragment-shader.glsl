varying vec2 vUvs;

uniform sampler2D diffuse;
uniform sampler2D overlay;
uniform vec4 tint;

void main(void) {
  vec2 uvs = vUvs / 10.0;
  vec4 diffuseSample = texture2D(diffuse, uvs);
  vec4 overlaySample = texture2D(overlay, vUvs);
  // gl_FragColor = mix(diffuseSample, overlaySample, overlaySample.w);
  gl_FragColor = diffuseSample;
}