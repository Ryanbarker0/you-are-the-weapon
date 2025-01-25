extends Node

@onready var hitbox_component: HitboxComponent = get_parent().get_node("HitboxComponent")


# Called when the node enters the scene tree for the first time.
func _ready():
	hitbox_component.hit_hurtbox.connect(on_bullet_hit)

func on_bullet_hit(hurtbox: HurtboxComponent) -> void:
	print("Hit Hurtbox ", hurtbox)
	get_parent().queue_free()

