
varying vec2 vUvs;

uniform vec2 resolution;

vec3 red = vec3(1.0, 0.0, 0.0);
vec3 blue = vec3(0.0, 0.0, 1.0);
vec3 white = vec3(1.0, 1.0, 1.0);
vec3 black = vec3(0.0, 0.0, 0.0);
vec3 yellow = vec3(1.0, 1.0, 0.0);

void main() {
  vec3 colour = vec3(0.0);

  float value1 = vUvs.x;
  // float value2 = smoothstep(0.0, 1.0, vUvs.x);
   float value2 = clamp(vUvs.x, 0.25, 0.75);

  // here just take y uv coord (0 bot, 1 top and subtract half to get middle value)
  // pass to smoothstep with rly small numbers to return value for these ranges, if outside ranges get nothing
  // will pass this to mix to blend with other things
  float line = smoothstep(0.0, 0.005, abs(vUvs.y - 0.5));
  float linearLine = smoothstep(0.0, 0.0075, abs(vUvs.y - mix(0.5, 1.0, value1)));
  // smooth line should take the smoothstepped version of vUvs.x value
  // pass 0.0 and 0.5 in mix to refer to bottom level
  float smoothLine = smoothstep(0.0, 0.0075, abs(vUvs.y - mix(0.0, 0.5, value2)));

  if(vUvs.y > 0.5) {
    colour = mix(red, blue, value1);
  } else {
    colour = mix(red, blue, value2);
  }

  // can just keep mixing with itself to get the steps we get
  // this is our horizontal line defined with a smoothstep on the abs
  colour = mix(white, colour, line);

  // mix in our lines that indicate the linear and smoothstep interps
  colour = mix(white, colour, linearLine);
  colour = mix(white, colour, smoothLine);


  // colour = vec3(vUvs.x);
  // colour = vec3(step(0.5, vUvs.x));
  // colour = mix(blue, red, vUvs.x);
  // colour = vec3(smoothstep(0.0, 1.0, vUvs.x));
  // colour = mix(red, blue, smoothstep(0.0, 1.0, vUvs.x));

  gl_FragColor = vec4(colour, 1.0);
}
