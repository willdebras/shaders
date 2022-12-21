
varying vec3 vNormal;
varying vec3 vPosition;
varying vec3 vColour;

uniform float time;


float inverseLerp(float v, float minValue, float maxValue) {
  return (v - minValue) / (maxValue - minValue);
}

float remap(float v, float inMin, float inMax, float outMin, float outMax) {
  float t = inverseLerp(v, inMin, inMax);
  return mix(outMin, outMax, t);
}


void main() {	
  vec3 localSpacePosition = position;

  float t = sin(localSpacePosition.y * 5.0 + time * 2.0);
  t = remap(t, -1.0, 1.0, 0.0, 0.3);
  localSpacePosition += normal * t;

  gl_Position = projectionMatrix * modelViewMatrix * vec4(localSpacePosition, 1.0);
  vNormal = (modelMatrix * vec4(normal, 0.0)).xyz;
  vPosition = (modelMatrix * vec4(localSpacePosition, 1.0)).xyz;
  vColour = mix(
      vec3(1.0, 0.55, 0.0),
      vec3(0.9, 0.0, 0.0),
      smoothstep(0.0, 0.3, t));
}