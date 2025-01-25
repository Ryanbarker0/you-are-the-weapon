extends Area2D
class_name Projectile

@onready var hitbox_component: HitboxComponent = $HitboxComponent

var speed = 1000 # Speed of the movement in pixels per second
var damage = 1
var max_pierce = 0
var projectile_lifetime = 3.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	projectile_lifetime -= delta
	if projectile_lifetime <= 0:
		queue_free()
	hitbox_component.damage = damage
	var direction = Vector2(cos(rotation), sin(rotation))
	position += direction * speed * delta

