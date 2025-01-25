extends Node

func display_number(value: int, position: Vector2, is_critical: bool = false) -> void:
	var number = Label.new()
	number.global_position = position
	number.text = str(value)
	number.z_index = 5
	number.label_settings = LabelSettings.new()

	var color = "#FFF"
	if is_critical:
		color = "#B22"
	if value == 0:
		color = "#FFF8"
	
	number.label_settings.font_color = color
	number.label_settings.font_size = 30
	number.label_settings.outline_color = "#000"
	number.label_settings.outline_size = 3

	call_deferred("add_child", number)

	await number.resized
	number.pivot_offset = Vector2(number.size / 2)

	var tween = get_tree().create_tween()
	tween.set_parallel(true)
	# tween.tween_property(number, "position:y", number.position.y - 24, 0.25).set_ease(Tween.EASE_OUT)
	# tween.tween_property(number, "position:y", number.position.y, 0.5).set_ease(Tween.EASE_IN).set_delay(0.25)
	# tween.tween_property(number, "scale", Vector2.ZERO, 0.25).set_ease(Tween.EASE_IN).set_delay(0.5)

	# Arcing effect: Simulate an upward arc by adjusting x and y independently
	var arc_height = 24  # Adjust height of the arc
	var arc_width = 10   # Adjust the width of the arc
	var target_x = position.x + randf_range(-arc_width, arc_width)  # Random horizontal deviation
	var target_y = position.y - arc_height  # Move upward for the arc

	# Move upward in an arc
	tween.tween_property(number, "global_position", Vector2(position.x, target_y), 0.25).set_ease(Tween.EASE_OUT)

	# Move downward to the target x position while returning to original y
	tween.tween_property(number, "global_position", Vector2(target_x, position.y), 0.5).set_ease(Tween.EASE_IN).set_delay(0.25)

	# Shrink effect at the end
	tween.tween_property(number, "scale", Vector2.ZERO, 0.25).set_ease(Tween.EASE_IN).set_delay(0.5)

	await tween.finished
	number.queue_free()

	
