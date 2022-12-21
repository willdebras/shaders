// this is texture sampled
uniform samplerCube specMap;
varying vec3 vNormal;
varying vec3 vPosition;

float inverseLerp(float v, float minValue, float maxValue) {
  return (v - minValue) / (maxValue - minValue);
}

float remap(float v, float inMin, float inMax, float outMin, float outMax) {
  float t = inverseLerp(v, inMin, inMax);
  return mix(outMin, outMax, t);
}

vec3 linearTosRGB(vec3 value ) {
  vec3 lt = vec3(lessThanEqual(value.rgb, vec3(0.0031308)));
  
  vec3 v1 = value * 12.92;
  vec3 v2 = pow(value.xyz, vec3(0.41666)) * 1.055 - vec3(0.055);

	return mix(v2, v1, lt);
}

void main() {
  vec3 baseColour = vec3(0.25, 0.0, 0.0);
  vec3 lighting = vec3(0.0);
  vec3 normal = normalize(vNormal);
  // view direction
  // camera comes from threejs
  vec3 viewDir = normalize(cameraPosition - vPosition);

//lights
  vec3 ambient = vec3(0.5);
  vec3 skyColour = vec3(0.0, 0.3, 0.6);
  vec3 groundColour = vec3(0.6, 0.3, 0.1);

  float hemiMix = remap(normal.y, -1.0, 1.0, 0.0, 1.0);
  vec3 hemi = mix(groundColour, skyColour, hemiMix);

  // diffuse lighting, lambertian
  vec3 lightDir = normalize(vec3(1.0, 1.0, 1.0));
  vec3 lightColour = vec3(1.0, 1.0, 0.9);
  // max bc we dont want negatives
  float dp = max(0.0, dot(lightDir, normal));
  vec3 diffuse = dp * lightColour;

  //phong specular gives u little bright reflections
  vec3 r = normalize(reflect(-lightDir, normal));
  float phongValue = max(0.0, dot(viewDir, r));
  phongValue = pow(phongValue, 2.0);
  vec3 specular = vec3(phongValue);

  // IBL Specular
  vec3 iblCoord = normalize(reflect(-viewDir, normal));
  vec3 iblSample = textureCube(specMap, iblCoord).xyz;

  specular += iblSample * 0.5;

  // fresnel effect (basically looking at grazing angle is higher specular effect)
  float fresnel = 1.0 - max(0.0, dot(viewDir, normal));
  // pow shapes curve of fall off
  // darker in middle, lighter at edges
  fresnel = pow(fresnel, 2.0);

  specular *= fresnel;

  lighting = ambient + -0.2 + hemi * 0.5 + diffuse * 0.5;

  vec3 colour = baseColour * lighting + specular;
  // colour = normal;

  // conver to srgb
  vec3 finalColour = linearTosRGB(colour);
  // can try this approximation instead of linearTosRGB func
  finalColour = pow(colour, vec3(1.0 / 2.2));

  gl_FragColor = vec4(finalColour, 1.0);
}