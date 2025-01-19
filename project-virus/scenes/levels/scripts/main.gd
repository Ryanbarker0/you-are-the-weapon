extends Node2D

@export var game_stats: GameStats

@onready var score_label: Label = $HUD/ScoreContainer/ScoreLabel

# Called when the node enters the scene tree for the first time.
func _ready():
	update_score_label(game_stats.score)
	game_stats.score_changed.connect(update_score_label)

func update_score_label(new_score: int) -> void:
	score_label.text = str(new_score)
