extends State
class_name NpcFlee

@export var npc: CharacterBody2D
@export var stats_component: StatsComponent
@export var infection_area: Area2D
@export var proximity_area: Area2D
@export var stressed_animation: AnimatedSprite2D
@export var character_animation: AnimatedSprite2D

var move_direction: Vector2
var wonder_time: float

var player: CharacterBody2D

func Enter():
	stats_component.move_speed = 80.0
	stressed_animation.show()
	stats_component.no_health.connect(on_no_health)
	proximity_area.body_exited.connect(on_proximity_area_body_exited)
	# use the proximity area to get the player's position
	var bodies_in_proximity = proximity_area.get_overlapping_bodies()
	# loop bodies and find the player
	for body in bodies_in_proximity:
		if body is Player:
			player = body
			break

func Update(_delta: float) -> void:
	if npc && player:
		move_direction = (npc.global_position - player.global_position).normalized()

func Physics_Update(_delta: float):
	if npc:
		npc.velocity = stats_component.move_speed * move_direction

# Class Specific Functions


# Signals
func on_no_health():
	stressed_animation.hide()
	stats_component.no_health.disconnect(on_no_health)
	proximity_area.body_exited.disconnect(on_proximity_area_body_exited)
	Transitioned.emit(self, "NpcInfected")

func on_proximity_area_body_exited(body:Node2D):
	if body is Player:
		stressed_animation.hide()
		# The NPC is no longer fleeing, so we no longer need to listen to the proximity area signal
		stats_component.no_health.disconnect(on_no_health)
		proximity_area.body_exited.disconnect(on_proximity_area_body_exited)
		Transitioned.emit(self, "NpcIdle")
