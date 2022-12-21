
varying vec2 vUvs;

void main() {
  vec3 colour = vec3(0.0);

  float value1 = step(0.5, vUvs.x);
  float value2 = mix(0.0, 1.0, vUvs.x);
  float value3 = smoothstep(0.0, 1.0, vUvs.x);

  float seperator1 = smoothstep(0.0, 0.005, abs(vUvs.y - 0.66));
  float seperator2 = smoothstep(0.0, 0.005, abs(vUvs.y - 0.33));
  float line1 = smoothstep(0.0, 0.0075, abs(vUvs.y - mix(0.66, 1.0, value1)));
  float line2 = smoothstep(0.0, 0.0075, abs(vUvs.y - mix(0.33, 0.66, value2)));
  float line3 = smoothstep(0.0, 0.0075, abs(vUvs.y - mix(0.0, 0.33, value3)));

  vec3 red = vec3(1.0, 0.0, 0.0);
  vec3 blue = vec3(0.0, 0.0, 1.0);
  vec3 white = vec3(1.0, 1.0, 1.0);
  vec3 black = vec3(0.0);

  if (vUvs.y > 0.66) {
    colour = mix(red, blue, value1);
  } else if (vUvs.y > 0.33) {
    colour = mix(red, blue, value2);
  } else {
    colour = mix(red, blue, value3);
  }

  colour = mix(black, colour, seperator1);
  colour = mix(black, colour, seperator2);
  colour = mix(white, colour, line1);
  colour = mix(white, colour, line2);
  colour = mix(white, colour, line3);

  gl_FragColor = vec4(colour, 1.0);
}