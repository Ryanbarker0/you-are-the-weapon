extends State
class_name EnemyChase

@export var enemy: CharacterBody2D
@export var move_speed: float = 80.0
@export var proximity_area: Area2D
@export var alert_spirte: AnimatedSprite2D

var move_direction: Vector2
var wonder_time: float

var player: CharacterBody2D


func Enter():
	alert_spirte.visible = true
	proximity_area.body_exited.connect(on_proximity_area_body_exited)
	# use the proximity area to get the player's position
	var bodies_in_proximity = proximity_area.get_overlapping_bodies()
	# loop bodies and find the player
	for body in bodies_in_proximity:
		if body is Player:
			player = body
			break
	pass

func Update(_delta: float) -> void:
	if enemy && player:
		move_direction = (player.global_position - enemy.global_position).normalized()
	pass

func Physics_Update(_delta: float):
	if enemy:
		enemy.velocity = move_speed * move_direction
	pass

# Class Specific Functions


# Signals

func on_proximity_area_body_exited(body:Node2D):
	if body is Player:
		alert_spirte.visible = false
		Transitioned.emit(self, "EnemyIdle")
		# The NPC is no longer fleeing, so we no longer need to listen to the proximity area signal
		proximity_area.body_exited.disconnect(on_proximity_area_body_exited)
