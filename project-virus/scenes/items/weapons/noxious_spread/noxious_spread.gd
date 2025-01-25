extends BaseProjectileSpawnerBehaviour
class_name NoxiousSpread

func initialise_behaviour(projectile_spawner: ProjectileSpawner, timer: Timer) -> PackedScene:
	timer.wait_time = 5
	var noxious_spread_scene: PackedScene = load("res://scenes/items/weapons/noxious_spread/noxious_spread.tscn")
	return noxious_spread_scene

func apply_behaviour(projectile_spawner: ProjectileSpawner, projectile: Area2D, delta: float):
	var player: Player = projectile_spawner.get_parent()
	var num_projectiles = 3  # Total number of projectiles
	var angle_step = TAU / num_projectiles  # TAU = 2π, total circle in radians
	
	# Generate a random starting angle
	var random_offset = randf() * TAU  # Random angle between 0 and 2π
	
	for i in range(num_projectiles):
		var new_projectile: Projectile = projectile.duplicate()
		new_projectile.speed = 400
		new_projectile.projectile_lifetime = 2
		player.get_tree().root.add_child(new_projectile)
		
		# Spawn projectiles at the player's position
		new_projectile.global_position = player.global_position
		
		# Calculate the angle for this projectile
		var angle = random_offset + i * angle_step
		new_projectile.rotation = angle
