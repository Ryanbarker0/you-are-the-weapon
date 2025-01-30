extends Control

@export var hud: CanvasLayer

func _on_button_pressed():
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 0, 0.5)
	await tween.finished
	get_tree().paused = false
	hud.show()
	queue_free()
