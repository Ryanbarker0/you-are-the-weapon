shader_type canvas_item;

// Pulsation speed and intensity (adjust as needed)
uniform float pulsation_speed : hint_range(0.0, 10.0, 0.1) = 1.0;
uniform float pulsation_intensity : hint_range(0.0, 1.0, 0.01) = 0.3;

// Base green tint color
uniform vec4 sickly_green_color : source_color = vec4(0.2, 0.8, 0.3, 1.0);

// Enable or disable the shader effect
uniform bool shader_enabled = true;

void fragment() {
    // Fetch the texture's color
    vec4 texture_color = texture(TEXTURE, UV);

    if (shader_enabled) {
        // Calculate pulsation effect
        float pulse = sin(TIME * pulsation_speed) * pulsation_intensity;

        // Apply the sickly green tint, modulated by pulsation
        vec3 sickly_tint = mix(texture_color.rgb, sickly_green_color.rgb, 0.5 + pulse);

        // Preserve texture alpha and combine with tinted color
        COLOR = vec4(sickly_tint, texture_color.a * sickly_green_color.a);
    } else {
        // If shader is disabled, use the original texture color
        COLOR = texture_color;
    }
}