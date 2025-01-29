extends Area2D

@onready var hud: CanvasLayer = get_parent().get_node("HUD")
@onready var upgrade_panel: Control = get_parent().get_node("Menus").get_node("UpgradePanel")

@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var audio_player: AudioStreamPlayer = $AudioStreamPlayer

@export var game_stats: GameStats

func _on_body_entered(body: Node2D):
	if body is Player:
		game_stats.current_xp += 1
		if game_stats.player_level == game_stats.current_xp:
			game_stats.player_level += 1
			game_stats.current_xp = 0
			hud.hide()
			upgrade_panel.show()
			get_tree().paused = true
			queue_free()
		else:
			audio_player.play()
			collision_shape.queue_free()
			hide()
			audio_player.finished.connect(queue_free)
