extends Button

@export var transition_color: ColorRect # Adjust the path if necessary
var fade_duration = 1.0 # Duration for fade in/out

func _on_pressed():
	# Start the fade-out animation
	var tween = get_tree().create_tween()
	transition_color.visible = true
	tween.tween_property(transition_color, "modulate:a", 1.0, fade_duration)
	tween.tween_callback(Callable(self, "_on_fade_out_complete"))

func _on_fade_out_complete():
	# Reload the scene after fade-out is done
	get_tree().reload_current_scene()
