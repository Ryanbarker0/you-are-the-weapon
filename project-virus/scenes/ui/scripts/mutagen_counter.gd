extends RichTextLabel

@export var stats: GameStats

func _ready():
	text = "%s / %s" % [stats.current_xp, stats.player_level]

func _process(delta):
	text = "%s / %s" % [stats.current_xp, stats.player_level]
