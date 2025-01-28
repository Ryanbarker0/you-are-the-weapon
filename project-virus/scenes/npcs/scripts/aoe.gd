extends Node2D

@onready var hitbox_component: HitboxComponent = $HitboxComponent
@onready var collision_shape: CollisionShape2D = $HitboxComponent/CollisionShape2D
@onready var particles: GPUParticles2D = $GPUParticles2D

@export var max_radius: float = 250.0
@export var duration: float = 1.0

@export var damage_max: int = 10
@export var damage_min: int = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	var aoe_damage = randi_range(damage_min, damage_max)
	hitbox_component.damage = aoe_damage
	collision_shape.shape.radius = 0.0
	particles.emitting = true
	var tween = get_tree().create_tween()
	tween.tween_property(collision_shape.shape, "radius", max_radius, duration)
	await tween.finished

func _process(delta):
	if not particles.emitting:
		queue_free()
