extends Control

const MAIN_SCENE_PATH: String = "res://scenes/levels/main.tscn" 
var loading_status: int
var progress: Array[float]

@onready var intro: PackedScene = preload("res://scenes/levels/Intro.tscn") 

@onready var SceneTransition: Node = get_node("/root/ScreenEffects/SceneTransitionAnimation")
@onready var animation_player: AnimationPlayer = SceneTransition.get_node("AnimationPlayer")
@onready var color_rect: ColorRect = SceneTransition.get_node("ColorRect")
@onready var menu_music: AudioStreamPlayer = $MenuMusic

@onready var volume_sliders: VBoxContainer = $VolumeSliders 

@onready var loading_overlay: CanvasLayer = $CanvasLayer
@onready var progress_bar : ProgressBar = $CanvasLayer/ProgressBar

func _ready():
	animation_player.play("fade_out")
	# Preload main scene in background
	ResourceLoader.load_threaded_request(MAIN_SCENE_PATH)

func _process(_delta: float) -> void:
	# Update the status:
	loading_status = ResourceLoader.load_threaded_get_status(MAIN_SCENE_PATH, progress)
	
	# Check the loading status:
	match loading_status:
		ResourceLoader.THREAD_LOAD_IN_PROGRESS:
			progress_bar.value = progress[0] * 100 # Change the ProgressBar value
		ResourceLoader.THREAD_LOAD_LOADED:
			# Could add a really short timer so we visibly display the progress hit 100% beforing hiding
			if progress_bar.value == 100:
				loading_overlay.visible = false
			progress_bar.value = 100
		ResourceLoader.THREAD_LOAD_FAILED:
			print("Error loading main scene")
	
func _on_infect_pressed():
	var main_scene_load_status = ResourceLoader.load_threaded_get_status(MAIN_SCENE_PATH)
	if main_scene_load_status == 3:
	# Start the fade-out animation
		var tween = get_tree().create_tween()
		tween.tween_property(menu_music, "volume_db", -80, 1.5)
		animation_player.animation_finished.connect(_on_fade_in_complete)
		animation_player.play("fade_in")

func _on_fade_in_complete(_arg):
	animation_player.animation_finished.disconnect(_on_fade_in_complete)
	# var loaded_main_scene: PackedScene = ResourceLoader.load_threaded_get(MAIN_SCENE_PATH)
	get_tree().change_scene_to_packed(intro)
