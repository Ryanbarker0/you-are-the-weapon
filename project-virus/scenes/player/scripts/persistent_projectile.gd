extends Area2D
class_name PersistentProjectile

@export var behaviour_controller: BasePersistentProjectileBehaviour

var upgrades: Array[BasePersistentProjectileUpgrade] = []
@onready var current_upgrade_amount: int = 0
@onready var parent: Node2D = get_parent()


# Called when the node enters the scene tree for the first time.
func _ready():
	behaviour_controller.initialise_behaviour(self)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	behaviour_controller.apply_behaviour(self, delta)

	if upgrades.size() != current_upgrade_amount:
		current_upgrade_amount = upgrades.size()
		upgrades[upgrades.size() - 1].apply_upgrade(self)