shader_type canvas_item;

uniform float time;
uniform float drip_amplitude = 0.05;
uniform float drip_speed = 3.0;
uniform float drip_frequency = 15.0;

void fragment() {
	vec2 uv = UV;
	uv.y += sin(uv.x * drip_frequency + time * drip_speed) * drip_amplitude * uv.y;
	COLOR = texture(TEXTURE, uv);
}
