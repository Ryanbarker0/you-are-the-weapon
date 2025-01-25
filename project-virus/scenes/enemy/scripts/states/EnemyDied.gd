extends State
class_name EnemyDied

@export var enemy: CharacterBody2D
@export var hitbox_component: HitboxComponent
@export var hurtbox_component: HurtboxComponent
@export var death_animation: AnimationPlayer
@export var health_bar: TextureProgressBar
@export var drop_rate_percent: int = 65
@export var score_component: ScoreComponent

var upgrade_item: PackedScene = preload("res://scenes/items/upgrade_item.tscn")

func Enter():
	enemy.velocity = Vector2.ZERO
	score_component.adjust_score(1)
	health_bar.queue_free()
	hitbox_component.queue_free()
	hurtbox_component.queue_free()
	death_animation.animation_finished.connect(on_animation_finished)
	death_animation.play("rotate_and_explode")

func Update(_delta: float) -> void:
	pass

func Physics_Update(_delta: float):
	pass

func on_animation_finished(_anim_name):
		## spawn items based on drop rate
	if randi() % 100 < drop_rate_percent:
		var upgrade_item_instance = upgrade_item.instantiate()
		upgrade_item_instance.global_position = enemy.global_position
		enemy.get_parent().get_parent().add_child(upgrade_item_instance)
	enemy.queue_free()
