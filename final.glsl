#ifdef GL_FRAGMENT_PRECISION_HIGH
precision highp float;
#endif

uniform vec2 resolution;
uniform float time ;

#include "func.h"
#include "coeff.glsl"

vec3 atmOverlay(vec3 cube){
    float chroma = min(cube.y, 0.0);
    cube.y = max(cube.y, 0.0);
    vec3 c_0 = resoCoeff();

    c_0 += vec3(0.60, 0.54 - exp(-cube.y * 25.0) * 0.05, 0.38) * exp(-cube.y * 4.0);
    c_0 += vec3(0.38, 0.52, 0.68) * 0.7 * (1.0 - exp(-cube.y * 7.0)) * exp(-cube.y * 0.9);
    c_0 *= mix(c_0 * 0.7, vec3(0.7)* 0.0, 0.88 - exp(chroma * 6.0)*0.7);
    return c_0;
}

void main(void) {
    vec2 uv = gl_FragCoord.xy / resolution.xy;
    vec4 intersect;

    vec3 coord = normalize(vec3(uv.x, uv.y - 0.128, uv.y));
    vec3 w_0 = sin(atmOverlay(coord));

    intersect.rgb += saturate(w_0);

    gl_FragColor = intersect;
}