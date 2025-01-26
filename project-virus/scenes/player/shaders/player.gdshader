shader_type canvas_item;

uniform vec4 outline_color : source_color = vec4(1.0, 1.0, 0.0, 1.0);
uniform float outline_size = 3.0;

void fragment() {
    vec2 uv = SCREEN_UV;
    float dist = length(uv - vec2(0.5));
    float radius = 0.4; // Adjust based on player size
    float edge = smoothstep(radius - outline_size * 0.01, radius, dist);
    COLOR = mix(outline_color, vec4(0.0), edge);
}
