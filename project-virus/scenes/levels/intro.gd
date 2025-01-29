extends Node2D

const MAIN_SCENE_PATH: String = "res://scenes/levels/main.tscn"

@onready var main_scene: PackedScene = preload(MAIN_SCENE_PATH)
@onready var SceneTransition: Node = get_node("/root/ScreenEffects/SceneTransitionAnimation")
@onready var animation_player: AnimationPlayer = SceneTransition.get_node("AnimationPlayer")
@onready var animation: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	animation_player.play("fade_out")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "WalkoutVirus":
		get_tree().change_scene_to_packed(main_scene)
