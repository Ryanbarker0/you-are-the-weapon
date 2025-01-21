class_name SpeedPlayerUpgrade
extends BasePlayerUpgrade


@export var speed_increase := 50.0


func apply_upgrade(player: Player):
	var playerstats = get_player_stats(player)
	playerstats.move_speed += speed_increase
