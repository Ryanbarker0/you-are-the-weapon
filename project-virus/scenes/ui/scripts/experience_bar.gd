extends TextureProgressBar

@export var game_stats: GameStats


# Called when the node enters the scene tree for the first time.
func _ready():
	max_value = 100
	value = game_stats.current_xp % 100


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	value = game_stats.current_xp % 100
