extends BaseProjectileSpawnerBehaviour
class_name ViralDischarge

@export var speed: float = 200
@export var damage: int = 1

func initialise_behaviour(projectile_spawner: ProjectileSpawner, timer: Timer) -> PackedScene:
	# configure time for timer, then start
	timer.wait_time = 0.5
	timer.start()
	var viral_discharge_scene: PackedScene = load("res://scenes/items/weapons/viral_discharge/viral_discharge.tscn")
	return viral_discharge_scene

# TODO: we need to add movement to the projectile
func apply_behaviour(projectile_spawner: ProjectileSpawner, projectile: PackedScene, delta: float):
	# we need to spawn the project and give it movement based on the player's direction
	# we can reference projectile_spawner.player to get the player's direction
	var projectile_instance: Node2D = projectile.instantiate()
	var hitbox_component: HitboxComponent = projectile_instance.get_node("HitboxComponent")
	hitbox_component.damage = damage
	projectile_spawner.player.get_tree().root.add_child(projectile_instance)

	projectile_instance.global_position = projectile_spawner.player.global_position
	projectile_instance.rotation = projectile_spawner.player.rotation
	projectile_instance.speed = projectile_spawner.player.speed
	
