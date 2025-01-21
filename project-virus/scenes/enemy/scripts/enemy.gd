extends CharacterBody2D
class_name Enemy

@onready var animated_sprite_2d = $AnimatedSprite2D

func _physics_process(_delta):
	move_and_slide()

	if velocity.x > 0:
		animated_sprite_2d.play("run_right")
	elif velocity.x < 0:
		animated_sprite_2d.play("run_left")

	if velocity.x == 0 && velocity.y == 0:
		animated_sprite_2d.play("idle_down")
