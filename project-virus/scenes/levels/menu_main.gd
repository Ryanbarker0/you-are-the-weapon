extends Control

const MAIN_SCENE_PATH: String = "res://scenes/levels/main.tscn" 

@onready var SceneTransition: Node = get_node("/root/ScreenEffects/SceneTransitionAnimation")
@onready var animation_player: AnimationPlayer = SceneTransition.get_node("AnimationPlayer")
@onready var color_rect: ColorRect = SceneTransition.get_node("ColorRect")

func _ready():
	animation_player.play("fade_out")
	# Preload main scene in background
	ResourceLoader.load_threaded_request(MAIN_SCENE_PATH)
	
func _on_infect_pressed():
	var main_scene_load_status = ResourceLoader.load_threaded_get_status(MAIN_SCENE_PATH)
	if main_scene_load_status == 3:
	# Start the fade-out animation
		animation_player.animation_finished.connect(_on_fade_in_complete)
		animation_player.play("fade_in")

func _on_fade_in_complete(_arg):
	animation_player.animation_finished.disconnect(_on_fade_in_complete)
	var loaded_main_scene: PackedScene = ResourceLoader.load_threaded_get(MAIN_SCENE_PATH)
	get_tree().change_scene_to_packed(loaded_main_scene)