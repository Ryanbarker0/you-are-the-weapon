extends State
class_name NpcIdle

@export var npc: CharacterBody2D
@export var move_speed: float = 10.0

var move_direction: Vector2
var wonder_time: float

var is_infected = false

func Enter():
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
func _on_infection_area_body_entered(body:Node2D):
	if body is Player && is_infected == false:
		is_infected = true
		Transitioned.emit(self, "NpcInfected")


