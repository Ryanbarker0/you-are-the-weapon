extends Area2D

@onready var hud: CanvasLayer = get_parent().get_node("HUD")
@onready var upgrade_panel: Control = get_parent().get_node("Menus").get_node("UpgradePanel")
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
		else:
			# Play audio
			queue_free()
			pass

