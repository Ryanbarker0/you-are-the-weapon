extends State
class_name HealerHeal

@export var healer: CharacterBody2D
@export var move_speed: float = 80.0
@export var infection_area: Area2D
@export var proximity_area: Area2D
@export var healing_animation: AnimatedSprite2D
@export var character_animation: AnimatedSprite2D

var move_direction: Vector2
var wonder_time: float

var current_npc: NPC

func Enter():
	healing_animation.show()
	# infection_area.hurt.connect(on_infection_hurtbox_entered)
	# proximity_area.body_exited.connect(on_proximity_area_body_exited)
	# use the proximity area to get the player's position
	var bodies_in_proximity = proximity_area.get_overlapping_bodies()
	# loop bodies and find the player
	for body in bodies_in_proximity:
		if body is NPC && body.get_node("StateMachine").current_state is NpcInfected:
			current_npc = body
			break
	pass

func Update(_delta: float) -> void:
	# Move healer towards the NPC
	if healer && current_npc:
		var npc_state = current_npc.get_node("StateMachine").current_state
		if npc_state is NpcDead:
			healing_animation.hide()
			Transitioned.emit(self, "HealerIdle")
		move_direction = (current_npc.global_position - healer.global_position).normalized()
		# We want to check if the healer is withing range of the NPC (maybe 10px?)
		if healer.global_position.distance_to(current_npc.global_position) < 10:
			# In range so go to Healing state
			Transitioned.emit(self, "HealerHealing")

func Physics_Update(_delta: float):
	if healer:
		healer.velocity = move_direction * move_speed
		healer.move_and_slide()
		if healer.velocity.x > 0:
			character_animation.play("run_right")
		elif healer.velocity.x < 0:
			character_animation.play("run_left")
		if healer.velocity.x == 0 && healer.velocity.y == 0:
			character_animation.play("idle_down")

# Class Specific Functions


# Signals
# func on_infection_hurtbox_entered(area: Area2D):
# 	if area is HitboxComponent:
# 		var _parent = area.get_parent()
# 		if _parent is Player:
# 			stressed_animation.hide()
# 			Transitioned.emit(self, "NpcInfected")
# 			# The NPC is infected, so we no longer need to listen to the infection or proximity area signal
# 			infection_area.hurt.disconnect(on_infection_hurtbox_entered)
# 			proximity_area.body_exited.disconnect(on_proximity_area_body_exited)

# func on_proximity_area_body_exited(body:Node2D):
# 	if body is Player:
# 		stressed_animation.hide()
# 		Transitioned.emit(self, "NpcIdle")
# 		# The NPC is no longer fleeing, so we no longer need to listen to the proximity area signal
# 		infection_area.hurt.disconnect(on_infection_hurtbox_entered)
# 		proximity_area.body_exited.disconnect(on_proximity_area_body_exited)
