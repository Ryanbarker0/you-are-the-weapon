extends Node2D

@export var game_stats: GameStats

@onready var score_label: RichTextLabel = $HUD/ScoreContainer/ScoreLabel
@onready var bio_icon: TextureRect = $HUD/ScoreContainer/MarginContainer/BioIcon

# Called when the node enters the scene tree for the first time.
func _ready():
	update_score_label(game_stats.score)
	game_stats.score_changed.connect(on_score_changed)

# Signal handler for score changes
func on_score_changed(new_score: int) -> void:
	animate_score_components(new_score)

# Function to update the score label text
func update_score_label(new_score: int) -> void:
	score_label.text = str(new_score)

# TODO: Play a sound effect when the score changes
func play_score_sound() -> void:
	# Add sound effect code here
	pass

# Function to animate the score label and icon
func animate_score_components(new_score: int) -> void:
	# Update the label text immediately
	update_score_label(new_score)

	play_score_sound()

	# Create a tween for the animation
	var tween = get_tree().create_tween()

	# Scale up the ScoreLabel and BioIcon simultaneously with a smoother transition
	tween.tween_property(score_label, "scale", Vector2(1.5, 1.5), 0.25).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.parallel().tween_property(bio_icon, "scale", Vector2(1.5, 1.5), 0.25).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	
	# Scale back down the ScoreLabel and BioIcon simultaneously with a smooth transition
	tween.tween_property(score_label, "scale", Vector2(1, 1), 0.25).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.parallel().tween_property(bio_icon, "scale", Vector2(1, 1), 0.25).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
