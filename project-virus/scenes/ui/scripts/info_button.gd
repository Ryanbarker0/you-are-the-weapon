extends Control

@export var hud: CanvasLayer

@onready var SceneTransition: Node = get_node("/root/ScreenEffects/SceneTransitionAnimation")
@onready var animation_player: AnimationPlayer = SceneTransition.get_node("AnimationPlayer")

@onready var main_scene: PackedScene = preload("res://scenes/levels/main.tscn")

func _ready():
	animation_player.play("fade_out")

func _on_fade_in_complete(_arg):
	animation_player.animation_finished.disconnect(_on_fade_in_complete)
	get_tree().change_scene_to_packed(main_scene)

func _on_button_pressed():
	animation_player.animation_finished.connect(_on_fade_in_complete)
	animation_player.play("fade_in")
