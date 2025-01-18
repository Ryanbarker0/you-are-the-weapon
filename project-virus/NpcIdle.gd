extends State
class_name NpcIdle

@export var npc: CharacterBody2D
@export var move_speed: float = 10.0

var move_direction: Vector2
var wonder_time: float

func randomize_wonder():
	move_direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
	wonder_time = randf_range(1, 3)

func Enter():
	randomize_wonder()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func Update(delta: float) -> void:
	if wonder_time > 0:
		wonder_time -= delta
	else:
		randomize_wonder()

func Physics_Update(delta: float):
	if npc:
		npc.velocity = move_direction * move_speed