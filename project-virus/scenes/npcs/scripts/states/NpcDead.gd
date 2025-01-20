extends State
class_name NpcDead

@export var npc: CharacterBody2D
@export var move_speed: float = 0.0
@export var deadanimation: AnimatedSprite2D

var move_direction: Vector2
var wonder_time: float

func Enter():
	##print("NPC is dead")
	deadanimation.rotate(70)
	

func Physics_Update(_delta: float):
	if npc:
		npc.velocity = move_direction * move_speed
