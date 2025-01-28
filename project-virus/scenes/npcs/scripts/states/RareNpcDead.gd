extends State
class_name RareNpcDead

@export var game_stats: GameStats

@export var npc: CharacterBody2D
@export var move_speed: float = 0.0
@export var death_animation: AnimationPlayer
@export var drop_rate_percent: int = 25
@export var score_component: ScoreComponent
@export var hurtbox_component: HurtboxComponent
@export var flash_component: FlashComponent
@export var health_bar: TextureProgressBar

var upgrade_item: PackedScene = preload("res://scenes/items/health_item.tscn")

var move_direction: Vector2
var wonder_time: float

func Enter():
	health_bar.hide()
	hurtbox_component.queue_free()
	flash_component.free()
	score_component.adjust_score(1)
	death_animation.play("rotate_and_explode")
	death_animation.animation_finished.connect(_on_animation_finished)

func Physics_Update(_delta: float):
	if npc:
		npc.velocity = move_direction * move_speed

func _on_animation_finished(_name):
	## spawn items based on drop rate
	if randi() % 100 < drop_rate_percent:
		var upgrade_item_instance = upgrade_item.instantiate()
		upgrade_item_instance.global_position = npc.global_position
		npc.get_parent().get_parent().add_child(upgrade_item_instance)
	game_stats.current_rare_npc -= 1
	npc.queue_free()
