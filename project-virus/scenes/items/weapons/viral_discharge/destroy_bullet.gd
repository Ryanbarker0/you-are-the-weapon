extends Node

@onready var hitbox_component: HitboxComponent = get_parent().get_node("HitboxComponent")
@onready var projectile: Projectile = get_parent()

var current_pierce_count: int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	hitbox_component.hit_hurtbox.connect(on_bullet_hit)

func on_bullet_hit(hurtbox: HurtboxComponent) -> void:
	current_pierce_count += 1

	if current_pierce_count >= projectile.max_pierce:
		get_parent().queue_free()
