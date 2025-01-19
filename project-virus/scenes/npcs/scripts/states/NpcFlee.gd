extends State
class_name NpcFlee

@export var npc: CharacterBody2D
@export var move_speed: float = 80.0
@export var infection_area: Area2D
@export var proximity_area: Area2D
@export var stressed_animation: AnimatedSprite2D
@export var character_animation: AnimatedSprite2D

var move_direction: Vector2
var wonder_time: float

var player: CharacterBody2D


func Enter():
	stressed_animation.show()
	infection_area.hurt.connect(on_infection_hurtbox_entered)
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
	if npc && player:
		move_direction = (npc.global_position - player.global_position).normalized()
	pass

func Physics_Update(_delta: float):
	if npc:
		npc.velocity = move_speed * move_direction
	pass

# Class Specific Functions


# Signals
func on_infection_hurtbox_entered(area: Area2D):
	if area is HitboxComponent:
		var _parent = area.get_parent()
		if _parent is Player:
			stressed_animation.hide()
			Transitioned.emit(self, "NpcInfected")
			# The NPC is infected, so we no longer need to listen to the infection or proximity area signal
			infection_area.hurt.disconnect(on_infection_hurtbox_entered)
			proximity_area.body_exited.disconnect(on_proximity_area_body_exited)

func on_proximity_area_body_exited(body:Node2D):
	if body is Player:
		stressed_animation.hide()
		Transitioned.emit(self, "NpcIdle")
		# The NPC is no longer fleeing, so we no longer need to listen to the proximity area signal
		infection_area.hurt.disconnect(on_infection_hurtbox_entered)
		proximity_area.body_exited.disconnect(on_proximity_area_body_exited)
