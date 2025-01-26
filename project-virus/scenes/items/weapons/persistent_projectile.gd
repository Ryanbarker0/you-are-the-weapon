extends Area2D
class_name PersistentProjectile

@export var damage_min: int = 1
@export var damage_max: int = 5
@export var behaviour_controller: BasePersistentProjectileBehaviour

var upgrades: Array[BasePersistentProjectileUpgrade] = []
@onready var current_upgrade_amount: int = 0
@onready var parent: Node2D = get_parent()
@onready var total_rotating_projectiles: Array[PersistentProjectile] = parent.total_rotating_projectiles
@onready var hitbox_component: HitboxComponent = $HitboxComponent


# Called when the node enters the scene tree for the first time.
func _ready():
	total_rotating_projectiles.append(self)
	behaviour_controller.initialise_behaviour(self, total_rotating_projectiles)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var damage = randi_range(damage_min, damage_max)
	hitbox_component.damage = damage
	behaviour_controller.apply_behaviour(self, delta)

	if upgrades.size() != current_upgrade_amount:
		current_upgrade_amount = upgrades.size()
		upgrades[upgrades.size() - 1].apply_upgrade(self)
