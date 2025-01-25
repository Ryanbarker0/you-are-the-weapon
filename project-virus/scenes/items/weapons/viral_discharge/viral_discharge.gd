extends BaseProjectileSpawnerBehaviour
class_name ViralDischarge

func initialise_behaviour(projectile_spawner: ProjectileSpawner, timer: Timer) -> PackedScene:
	timer.wait_time = 5
	var viral_discharge_scene: PackedScene = load("res://scenes/items/weapons/viral_discharge/viral_discharge.tscn")
	return viral_discharge_scene

func apply_behaviour(projectile_spawner: ProjectileSpawner, projectile: Area2D, delta: float):
	print("Running applied behaviour")
	# we need to spawn the project and give it movement based on the player's direction
	# we can reference projectile_spawner.player to get the player's direction
	var player: Player = projectile_spawner.get_parent()
	player.get_tree().root.add_child(projectile)
		
	projectile.global_position = player.global_position
	# Determine the direction based on player's velocity
	var direction = player.velocity.normalized()
	projectile.rotation = direction.angle()
	
