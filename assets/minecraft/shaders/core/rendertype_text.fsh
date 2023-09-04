#version 150

#moj_import <fog.glsl>

uniform sampler2D Sampler0;

uniform vec4 ColorModulator;
uniform float FogStart;
uniform float FogEnd;
uniform vec4 FogColor;
uniform vec2 ScreenSize; // Sidebar Score Remover

in float vertexDistance;
in vec4 vertexColor;
in vec2 texCoord0;

out vec4 fragColor;

void main() {
    vec4 color = texture(Sampler0, texCoord0) * vertexColor * ColorModulator;
    if (color.a < 0.1) discard;
    fragColor = linear_fog(color, vertexDistance, FogStart, FogEnd, FogColor);

    // Sidebar Score Remover start
    if (
        ScreenSize.x - gl_FragCoord.x < 69
        && fragColor.a == 1.0
        && fragColor.r == 0.988235294 // 252 - FC
        && fragColor.g == 0.329411765 // 84 - 54
        && fragColor.b == 0.329411765 // 84 - 54
    ) {
        discard;
    }
    // Sidebar Score Remover end
}
