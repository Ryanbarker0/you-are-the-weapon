extends Area2D

func _on_body_entered(body):
	if body is Player:
		body.stats_component.health += 1
		queue_free()
