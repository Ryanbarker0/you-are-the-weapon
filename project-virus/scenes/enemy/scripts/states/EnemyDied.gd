extends State
class_name EnemyDied

@export var enemy: CharacterBody2D
@export var hitbox_component: HitboxComponent
@export var hurtbox_component: HurtboxComponent
@export var death_animation: AnimationPlayer

func Enter():
	enemy.velocity = Vector2.ZERO
	hitbox_component.queue_free()
	hurtbox_component.queue_free()
	death_animation.animation_finished.connect(on_animation_finished)
	death_animation.play("rotate_and_explode")

func Update(_delta: float) -> void:
	pass

func Physics_Update(_delta: float):
	pass

func on_animation_finished(_anim_name):
	enemy.queue_free()