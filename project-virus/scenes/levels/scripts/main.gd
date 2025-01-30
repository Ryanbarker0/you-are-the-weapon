extends Node2D

@export var game_stats: GameStats
@export var player: Player

@onready var camera: Camera2D = $Camera2D

@onready var SceneTransition: Node = get_node("/root/ScreenEffects/SceneTransitionAnimation")
@onready var animation_player: AnimationPlayer = SceneTransition.get_node("AnimationPlayer")
@onready var color_rect: ColorRect = SceneTransition.get_node("ColorRect")

# Music element
@onready var game_over_music: AudioStreamPlayer = $GameOver
@onready var game_music: AudioStreamPlayer = $LevelMusic

# HUD elements
@onready var hud: CanvasLayer = $HUD
@onready var score_container: HBoxContainer = $HUD/ScoreContainer
@onready var score_label: RichTextLabel = $HUD/ScoreContainer/ScoreLabel
@onready var bio_icon: TextureRect = $HUD/ScoreContainer/MarginContainer/BioIcon
@onready var healthpath: Control = $HUD/HealthBar
@onready var health_bar: ProgressBar = $HUD/HealthBar/ProgressBar
@onready var mutation_container: HBoxContainer = $HUD/MutationCounter
@onready var mutation_label: RichTextLabel = $HUD/MutationCounter/ScoreLabel
@onready var mutation_icon: TextureRect = $HUD/MutationCounter/MarginContainer/BioIcon

# Menu elements
@onready var game_over_screen: Control = $Menus/GameOver
@onready var upgrade_panel: Control = $Menus/UpgradePanel
@onready var pause_screen: Control = $Menus/PauseScreen

func _ready():
	animation_player.play("fade_out")
	fade_in_game_music()
	# Initialize the game stats
	game_stats.score = 0
	game_stats.current_xp = 0
	game_stats.player_level = 1
	update_score_label(game_stats.score)
	game_stats.score_changed.connect(on_score_changed)
	game_stats.current_xp_changed.connect(on_current_xp_changed)
	var children = player.get_children()
	for child in children:
		if child is DestroyComponent:
			child.destroyed.connect(on_player_destroyed)

func fade_in_game_music():
	game_music.volume_db = -80
	game_music.play()
	var tween = get_tree().create_tween()
	tween.tween_property(game_music, "volume_db", 0, 0.8)

func on_current_xp_changed(xp: int):
		# Create a tween for the animation
	var tween = get_tree().create_tween()

	# Scale up the ScoreLabel and BioIcon simultaneously with a smoother transition
	tween.tween_property(mutation_label, "scale", Vector2(1.5, 1.5), 0.25).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.parallel().tween_property(mutation_icon, "scale", Vector2(1.5, 1.5), 0.25).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	
	# Scale back down the ScoreLabel and BioIcon simultaneously with a smooth transition
	tween.tween_property(mutation_label, "scale", Vector2(1, 1), 0.25).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.parallel().tween_property(mutation_icon, "scale", Vector2(1, 1), 0.25).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)

# Signal handler for score changes
func on_score_changed(new_score: int) -> void:
	animate_score_components(new_score)

# Function to update the score label text
func update_score_label(new_score: int) -> void:
	score_label.text = str(new_score)

# Function to animate the score label and icon
func animate_score_components(new_score: int) -> void:
	# Update the label text immediately
	update_score_label(new_score)

	# Create a tween for the animation
	var tween = get_tree().create_tween()

	# Scale up the ScoreLabel and BioIcon simultaneously with a smoother transition
	tween.tween_property(score_label, "scale", Vector2(1.5, 1.5), 0.25).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.parallel().tween_property(bio_icon, "scale", Vector2(1.5, 1.5), 0.25).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	
	# Scale back down the ScoreLabel and BioIcon simultaneously with a smooth transition
	tween.tween_property(score_label, "scale", Vector2(1, 1), 0.25).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.parallel().tween_property(bio_icon, "scale", Vector2(1, 1), 0.25).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)

func on_player_destroyed(_actor: Node2D) -> void:
	score_container.hide()
	game_stats.final_score = game_stats.score
	game_over_screen.visible = true
	# Music Change
	game_music.stop()
	game_over_music.play()
	# TODO: Could move this to the node itself to remove separation of concerns
	game_over_screen.modulate = Color(1, 1, 1, 0) # Start fully transparent

	# Create a tween for the fade-in effect
	var tween = get_tree().create_tween()
	tween.tween_property(game_over_screen, "modulate", Color(1, 1, 1, 1), 0.5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
