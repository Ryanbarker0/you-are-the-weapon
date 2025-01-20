extends StaticBody2D
class_name ScenaryItem

@onready var area2d: Area2D = $Area2D
@onready var sprite: Sprite2D = $Sprite2D

var tween: Tween

func _ready():
	area2d.body_entered.connect(_on_body_entered)
	area2d.body_exited.connect(_on_body_exited)

func _on_body_entered(body):
	if body is Player:
		if tween:
			tween.kill()
		tween = create_tween()
		tween.tween_property(sprite, "modulate:a", 0.5, 0.7)

func _on_body_exited(body):
	if body is Player:
		if tween:
			tween.kill()
		tween = create_tween()
		tween.tween_property(sprite, "modulate:a", 1.0, 0.7)  # Fade to 100% transparency over 0.5 seconds