extends State
class_name HealerIdle

@export var healer: CharacterBody2D
@export var character_animation: AnimatedSprite2D
@export var move_speed: float = 50.0
@export var proximity_area: Area2D
@export var scan_component: ScanComponent

var move_direction: Vector2
var wonder_time: float

func Enter():
	scan_component.enabled = true
	scan_component.body_detected.connect(on_npc_found)
	# proximity_area.body_entered.connect(on_proximity_area_entered)
	randomize_wonder()

func Update(delta: float) -> void:
	if wonder_time > 0:
		wonder_time -= delta
	else:
		randomize_wonder()

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
func randomize_wonder():
	move_direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
	wonder_time = randf_range(1, 3)

# Signals
func on_npc_found(npc: NPC):
	var npc_state: State = npc.get_node("StateMachine").current_state
	if npc_state is NpcInfected:
		scan_component.enabled = false
		scan_component.body_detected.disconnect(on_npc_found)
		Transitioned.emit(self, "HealerHeal")

# func on_proximity_area_entered(body:Node2D):
# 	if body is NPC:
# 		var npc_state: State = body.get_node("StateMachine").current_state
# 		if npc_state is NpcInfected:
# 			Transitioned.emit(self, "HealerHeal")
# 			# # The NPC is fleeing, so we no longer need to listen to the proximity area signal
# 			proximity_area.body_entered.disconnect(on_proximity_area_entered)
		
