extends CharacterBody2D
class_name Player

@export var stats_component: StatsComponent

func _physics_process(_delta):
	# Get the input direction and handle the movement.
	var direction = Vector2(
		Input.get_axis("move_left", "move_right"),
		Input.get_axis("move_up", "move_down")
	).normalized()

	velocity = direction * stats_component.move_speed

	move_and_slide()
