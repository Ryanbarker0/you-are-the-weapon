extends Control

@onready var SceneTransition: Node = get_node("/root/ScreenEffects/SceneTransitionAnimation")
@onready var animation_player: AnimationPlayer = SceneTransition.get_node("AnimationPlayer")

@export var hud: CanvasLayer

func _process(delta):
	if Input.is_action_just_pressed("pause"):
		if not get_tree().paused:
			get_tree().paused = true
			hud.hide()
			show()
		else:
			get_tree().paused = false
			hud.show()
			hide()

func on_resume_pressed():
	get_tree().paused = false
	hide()
	hud.show()

func _on_quit_pressed():
	get_tree().paused = false
	animation_player.animation_finished.connect(load_main_menu_scene)
	animation_player.play("fade_in")

func load_main_menu_scene(_arg):
	animation_player.animation_finished.disconnect(load_main_menu_scene)
	get_tree().change_scene_to_file("res://scenes/ui/menu_main.tscn")