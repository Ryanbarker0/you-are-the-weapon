extends BaseProjectileSpawnerBehaviour
class_name ViralDischarge

func initialise_behaviour(projectile_spawner: ProjectileSpawner, timer: Timer) -> PackedScene:
	timer.wait_time = 5
	var viral_discharge_scene: PackedScene = load("res://scenes/items/weapons/viral_discharge/viral_discharge.tscn")
	return viral_discharge_scene

func apply_behaviour(projectile_spawner: ProjectileSpawner, projectile: Area2D, delta: float):
	# var player: Player = projectile_spawner.get_parent()
	# player.get_tree().root.add_child(projectile)
		
	# projectile.global_position = player.global_position
	# # Determine the direction based on player's velocity
	# var direction = player.velocity.normalized()
	# projectile.rotation = direction.angle()
	# projectile.projectile_lifetime = 5.0
	

	## This will handle multiple projectiles being spawned and cause them to spread
	
	var player: Player = projectile_spawner.get_parent()
	
	# Determine the direction based on the player's velocity
	var base_direction = player.velocity.normalized()
	var base_angle = base_direction.angle()
	
	# Define the spread angle (in radians)
	var spread_angle = deg_to_rad(15)  # 15 degrees between projectiles

	# Spawn three projectiles
	for i in range(-1, 2):  # -1, 0, 1 for left, center, right projectiles
		var new_projectile = projectile.duplicate() as Area2D
		player.get_tree().root.add_child(new_projectile)
		
		new_projectile.global_position = player.global_position
		
		# Adjust the angle for each projectile
		var angle_offset = i * spread_angle
		var final_angle = base_angle + angle_offset
		new_projectile.rotation = final_angle
