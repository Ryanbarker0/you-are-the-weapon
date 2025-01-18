extends CharacterBody2D
class_name Player

@export var SPEED: float = 300.0

func _physics_process(_delta):
	# Get the input direction and handle the movement.
	var direction = Vector2(
		Input.get_axis("move_left", "move_right"),
		Input.get_axis("move_up", "move_down")
	).normalized()

	velocity = direction * SPEED

	move_and_slide()
