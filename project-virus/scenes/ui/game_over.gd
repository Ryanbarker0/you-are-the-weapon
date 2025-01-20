extends Control

@onready var SceneTransition: Node = get_node("/root/ScreenEffects/SceneTransitionAnimation")
@onready var animation_player: AnimationPlayer = SceneTransition.get_node("AnimationPlayer")
@onready var color_rect: ColorRect = SceneTransition.get_node("ColorRect")

func _on_play_again_pressed():
	animation_player.animation_finished.connect(reload_game_scene)
	animation_player.play("fade_in")

func reload_game_scene(_arg):
	animation_player.animation_finished.disconnect(reload_game_scene)
	get_tree().reload_current_scene()

func _on_quit_pressed():
	animation_player.animation_finished.connect(load_main_menu_scene)
	animation_player.play("fade_in")

func load_main_menu_scene(_arg):
	animation_player.animation_finished.disconnect(load_main_menu_scene)
	get_tree().change_scene_to_file("res://scenes/levels/menu_main.tscn")
