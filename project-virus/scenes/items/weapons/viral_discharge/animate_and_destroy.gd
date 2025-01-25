extends Node

@onready var hitbox_component: HitboxComponent = get_parent().get_node("HitboxComponent")
@onready var projectile: Projectile = get_parent()
@onready var explode_animation: AnimationPlayer = get_parent().get_node("AnimationPlayer")

var current_pierce_count: int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	hitbox_component.hit_hurtbox.connect(on_bullet_hit)
	explode_animation.animation_finished.connect(on_animation_finished)

func on_bullet_hit(hurtbox: HurtboxComponent) -> void:
	current_pierce_count += 1

	if current_pierce_count >= projectile.max_pierce:
		projectile.speed = 0
		hitbox_component.queue_free()
		explode_animation.play("viral_discharge_explode")

func on_animation_finished(_anim_name: String):
	get_parent().queue_free()
