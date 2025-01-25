extends Node2D
class_name ProjectileSpawner

@export var behaviour_controller: BaseProjectileSpawnerBehaviour

var upgrades: Array[BaseProjectileSpawnerUpgrade] = []
@onready var player: Player = get_parent()
@onready var current_upgrade_amount: int = 0
@onready var parent: Node2D = get_parent()
@onready var timer: Timer = get_parent().get_node("FireTimer")

var projectile: PackedScene

var viral_discharge_scene: PackedScene = load("res://scenes/items/weapons/viral_discharge/viral_discharge.tscn")

var is_bullet_fired: bool = true

# 1. create timer
# 2. on timer expired, we create and fire a projectile
# 3. we then apply any upgrades to the projectile
# 4. then we set the flag to say it's fired back to true

func _ready():
	# var timer = Timer.new()
	# parent.add_child(timer)
	timer.timeout.connect(on_timer_timeout)
	# projectile = behaviour_controller.initialise_behaviour(self, timer)
	# timer.wait_time = 0.5
	# timer.start()

func _physics_process(delta):
	if !is_bullet_fired:
		# behaviour_controller.apply_behaviour(self, projectile, delta)
		var projectile_instance: Node2D = viral_discharge_scene.instantiate()
		# var hitbox_component: HitboxComponent = projectile_instance.get_node("HitboxComponent")
		# hitbox_component.damage = 1
		player.get_tree().root.add_child(projectile_instance)
		
		projectile_instance.global_position = player.global_position
		# Determine the direction based on player's velocity
		var direction = player.velocity.normalized()
		projectile_instance.rotation = direction.angle()

		is_bullet_fired = true
		# projectile_instance.speed = 50

		# if upgrades.size() != current_upgrade_amount:
		# 	current_upgrade_amount = upgrades.size()
		# 	upgrades[upgrades.size() - 1].apply_upgrade(self)


func on_timer_timeout():
	is_bullet_fired = false
