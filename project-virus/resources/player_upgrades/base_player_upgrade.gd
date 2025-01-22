class_name BasePlayerUpgrade
extends Resource


@export var texture : Texture2D = preload("res://scenes/levels/assets/items/animated_sprout_48x48.png")
@export var upgrade_text : String = "Speed"


func apply_upgrade(player: Player):
	pass

func get_player_stats(player: Player) -> StatsComponent:
	return player.get_node("StatsComponent")
	
