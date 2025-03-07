extends CharacterBody2D
class_name Player

@export var stats_component: StatsComponent

var upgrades: Array[BasePlayerUpgrade] = []
var total_rotating_projectiles: Array[PersistentProjectile]	= []
@onready var current_upgrade_amount: int = 0
@onready var hitbox_component: HitboxComponent = $HitboxComponent
@onready var camera: Camera2D = get_parent().get_parent().get_node("Camera2D")

func _process(_delta):
	var damage = randi_range(stats_component.damage_min, stats_component.damage_max)
	hitbox_component.damage = damage

func _physics_process(_delta):
	# Get the input direction and handle the movement.
	var direction = Vector2(
		Input.get_axis("move_left", "move_right"),
		Input.get_axis("move_up", "move_down")
	).normalized()

	velocity = direction * stats_component.move_speed
	if upgrades.size() != current_upgrade_amount:
		current_upgrade_amount = upgrades.size()
		upgrades[upgrades.size() - 1].apply_upgrade(self)
	move_and_slide()
