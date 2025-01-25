extends State
class_name NpcIdle

@export var npc: CharacterBody2D
@export var stats_component: StatsComponent
@export var proximity_area: Area2D

@onready var move_speed: float = stats_component.move_speed

var move_direction: Vector2
var wonder_time: float

func Enter():
	stats_component.no_health.connect(on_no_health)
	proximity_area.body_entered.connect(on_proximity_area_entered)
	randomize_wonder()

func Update(delta: float) -> void:
	if wonder_time > 0:
		wonder_time -= delta
	else:
		randomize_wonder()

func Physics_Update(_delta: float):
	if npc:
		npc.velocity = move_direction * move_speed

# Class Specific Functions
func randomize_wonder():
	move_direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
	wonder_time = randf_range(1, 3)

# Signals
func on_no_health():
	stats_component.no_health.disconnect(on_no_health)
	proximity_area.body_entered.disconnect(on_proximity_area_entered)
	Transitioned.emit(self, "NpcDead")

func on_proximity_area_entered(body:Node2D):
	if body is Player:
		stats_component.no_health.disconnect(on_no_health)
		proximity_area.body_entered.disconnect(on_proximity_area_entered)
		Transitioned.emit(self, "NpcFlee")
		
		
