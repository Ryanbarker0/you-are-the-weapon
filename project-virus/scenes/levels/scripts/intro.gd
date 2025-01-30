extends Node2D

const INFO_SCENE_PATH: String = "res://scenes/ui/info.tscn"

@onready var info_scene: PackedScene = preload(INFO_SCENE_PATH)
@onready var SceneTransition: Node = get_node("/root/ScreenEffects/SceneTransitionAnimation")
@onready var animation_player: AnimationPlayer = SceneTransition.get_node("AnimationPlayer")
@onready var animation: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	animation_player.play("fade_out")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "WalkoutVirus":
		animation_player.animation_finished.connect(_on_fade_in_complete)
		animation_player.play("fade_in")

func _on_fade_in_complete(_arg):
	animation_player.animation_finished.disconnect(_on_fade_in_complete)
	get_tree().change_scene_to_packed(info_scene)

func _on_button_pressed():
	animation_player.animation_finished.connect(_on_fade_in_complete)
	animation_player.play("fade_in")
