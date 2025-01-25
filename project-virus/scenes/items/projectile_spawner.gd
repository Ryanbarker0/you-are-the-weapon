extends Node2D
class_name ProjectileSpawner

@export var behaviour_controller: BaseProjectileSpawnerBehaviour

var upgrades: Array[BaseProjectileSpawnerUpgrade] = []
@onready var player: Player = get_parent()
@onready var current_upgrade_amount: int = 0
@onready var parent: Node2D = get_parent()
@onready var timer: Timer = Timer.new()

var projectile: PackedScene

var is_bullet_fired: bool = true

func _ready():
	timer.timeout.connect(on_timer_timeout)
	timer.autostart = true
	timer.process_callback = Timer.TIMER_PROCESS_PHYSICS
	player.add_child(timer)
	projectile = behaviour_controller.initialise_behaviour(self, timer)

func _physics_process(delta):
	if !is_bullet_fired:
		var projectile_instance: Area2D = projectile.instantiate()
		print("Starting behaviour in projectile...")
		behaviour_controller.apply_behaviour(self, projectile_instance, delta)

		# if upgrades.size() != current_upgrade_amount:
		# 	current_upgrade_amount = upgrades.size()
		# 	upgrades[upgrades.size() - 1].apply_upgrade(self)

		is_bullet_fired = true

func on_timer_timeout():
	print("timer timeout...")
	is_bullet_fired = false
