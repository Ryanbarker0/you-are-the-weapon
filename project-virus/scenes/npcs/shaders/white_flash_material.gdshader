shader_type canvas_item;
render_mode unshaded;

void fragment() {
	// Output green for every pixel but keep the alpha
	vec4 input_color = texture(TEXTURE, UV);
	COLOR = vec4(0.0, 1.0, 0.0, input_color.a);
}
