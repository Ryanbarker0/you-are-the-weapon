extends Area2D
class_name Projectile

@onready var hitbox_component: HitboxComponent = $HitboxComponent

@export var damage_min: int = 1
@export var damage_max: int = 5

var speed = 1000 # Speed of the movement in pixels per second
var max_pierce = 0
var projectile_lifetime = 3.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	projectile_lifetime -= delta
	if projectile_lifetime <= 0:
		queue_free()
	var damage = randi_range(damage_min, damage_max)
	if is_instance_valid(hitbox_component):
		hitbox_component.damage = damage
	var direction = Vector2(cos(rotation), sin(rotation))
	position += direction * speed * delta
