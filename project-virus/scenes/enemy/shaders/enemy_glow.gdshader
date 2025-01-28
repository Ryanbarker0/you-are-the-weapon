shader_type canvas_item;

// Exported variables for customization
uniform vec3 glow_color : source_color = vec3(1.0, 0.0, 0.0); // Default glow color (red)
uniform float glow_intensity : hint_range(1.0, 5.0) = 2.0;    // Base glow intensity
uniform float pulse_speed : hint_range(0.1, 5.0) = 1.0;       // Speed of the pulse

void fragment() {
	// Fetch the texture color
	vec4 tex_color = texture(TEXTURE, UV);

	// Create a pulsing effect using a sine wave
	float pulse = sin(TIME * pulse_speed) * 0.5 + 0.5; // Smooth value between 0.0 and 1.0

	// Amplify the glow color based on intensity and pulse
	vec3 glow_effect = glow_color * (pulse * glow_intensity);

	// Add the glow effect to the texture's original color (additive blending)
	COLOR = vec4(tex_color.rgb + glow_effect, tex_color.a);
}
