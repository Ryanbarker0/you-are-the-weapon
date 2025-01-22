extends Area2D

@export var sprite : AnimatedSprite2D
@export var player_upgrade : BasePlayerUpgrade:
	set(val):
		player_upgrade = val

func _on_body_entered(body):
	if body is Player:
		body.upgrades.append(player_upgrade)
		queue_free()
