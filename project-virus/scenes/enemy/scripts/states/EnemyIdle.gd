extends State
class_name EnemyIdle

@export var enemy: CharacterBody2D
@export var move_speed: float = 50.0
@export var proximity_area: Area2D
@export var stats_component: StatsComponent

var move_direction: Vector2
var wonder_time: float

func Enter():
	# Subscribe to infection area signal
	stats_component.no_health.connect(on_no_health)
	proximity_area.body_entered.connect(on_proximity_area_body_entered)
	randomize_wonder()

func Update(delta: float) -> void:
	if wonder_time > 0:
		wonder_time -= delta
	else:
		randomize_wonder()

func Physics_Update(_delta: float):
	if enemy:
		enemy.velocity = move_direction * move_speed

# Class Specific Functions
func randomize_wonder():
	move_direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
	wonder_time = randf_range(1, 3)

# Signals
func on_proximity_area_body_entered(body:Node2D):
	if body is Player:
		stats_component.no_health.disconnect(on_no_health)
		proximity_area.body_entered.disconnect(on_proximity_area_body_entered)
		Transitioned.emit(self, "EnemyChase")
		

func on_no_health():
	# stats_component.no_health.disconnect(on_no_health)
	# proximity_area.body_entered.disconnect(on_proximity_area_body_entered)
	Transitioned.emit(self, "EnemyDied")
