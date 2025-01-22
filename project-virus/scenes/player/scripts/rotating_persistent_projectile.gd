extends BasePersistentProjectileBehaviour
class_name RotatingPersistentProjectileBehaviour

var orbit_angle: float = 0.0

@export var orbit_speed: float = 5.0:
	set(value):
		orbit_speed = value
@export var orbit_radius: float = 100.0:
	set(value):
		orbit_radius = value

func initialise_behaviour(persistent_projectile: PersistentProjectile):
	orbit_angle = (persistent_projectile.global_position - persistent_projectile.parent.global_position).angle()

func apply_behaviour(persistent_projectile: PersistentProjectile, delta: float):
	# Update the orbit angle
	orbit_angle += orbit_speed * delta
	# Calculate new global position based on orbit angle and radius
	persistent_projectile.global_position = persistent_projectile.parent.global_position + Vector2(cos(orbit_angle), sin(orbit_angle)) * orbit_radius
	# Optional: Update the rotation of the object (e.g., to face the orbit direction)
	persistent_projectile.rotation = orbit_angle
