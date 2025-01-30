shader_type canvas_item;

uniform float radius : hint_range(0.0, 50.0); // Corner radius
uniform sampler2D texture_albedo; // Texture for the progress bar

void fragment() {
	vec2 uv = UV;
	vec4 tex_color = texture(texture_albedo, uv); // Sample the progress bar texture

	// Get the pixel position relative to a [0,1] range
	vec2 pos = uv;
	vec2 size = vec2(1.0, 1.0); // Assuming the texture is normalized

	// Calculate rounded rectangle boundaries
	vec2 corner_dist = min(pos, size - pos); 
	float dist = min(corner_dist.x, corner_dist.y);

	// Smoothstep function to blend alpha smoothly
	float alpha = smoothstep(0.0, radius / size.x, dist);

	// Apply rounded mask while keeping the texture color
	COLOR = tex_color;
	COLOR.a *= alpha; // Apply rounded mask only to the alpha channel
}
