extends BasePersistentProjectileBehaviour
class_name ContagionsOrbit

var orbit_angle: float = 0.0

@export var orbit_speed: float = 5.0:
	set(value):
		orbit_speed = value
@export var orbit_radius: float = 100.0:
	set(value):
		orbit_radius = value

func initialise_behaviour(persistent_projectile: PersistentProjectile, projectiles: Array[PersistentProjectile]):
	if not projectiles.has(persistent_projectile):
		projectiles.append(persistent_projectile)
		
	# Recalculate the positions of all projectiles
	_recalculate_projectile_positions(projectiles)

func apply_behaviour(persistent_projectile: PersistentProjectile, delta: float):
	# Update the orbit angle
	orbit_angle += orbit_speed * delta
	# Calculate new global position based on orbit angle and radius
	persistent_projectile.global_position = persistent_projectile.parent.global_position + Vector2(cos(orbit_angle), sin(orbit_angle)) * orbit_radius
	# Optional: Update the rotation of the object (e.g., to face the orbit direction)
	persistent_projectile.rotation = orbit_angle


func _recalculate_projectile_positions(projectiles: Array[PersistentProjectile]):
	# Get the total number of projectiles
	var total_projectiles = projectiles.size()
	if total_projectiles == 0:
		return

	# Recalculate the position of each projectile
	for i in range(total_projectiles):
		var angle = i * (2.0 * PI / total_projectiles)
		var projectile = projectiles[i]

		# Set the projectile's position based on the calculated angle
		projectile.global_position = projectile.parent.global_position + Vector2(cos(angle), sin(angle)) * orbit_radius

		# Update the orbit_angle for each projectile
		var behaviour = projectile.behaviour_controller
		if behaviour is ContagionsOrbit:
			behaviour.orbit_angle = angle
