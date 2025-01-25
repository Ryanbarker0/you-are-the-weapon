extends Label

@export var game_stats: GameStats

func _process(_delta):
	text = str(game_stats.final_score)
