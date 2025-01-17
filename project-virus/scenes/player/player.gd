extends CharacterBody2D


const SPEED = 300.0

func _physics_process(delta):
    # Get the input direction and handle the movement.
    var direction = Vector2(
        Input.get_axis("ui_left", "ui_right"),
        Input.get_axis("ui_up", "ui_down")
    ).normalized()

    velocity = direction * SPEED

    move_and_slide()
