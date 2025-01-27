extends CharacterBody2D

@onready var animated_sprite_2d = $AnimatedSprite2D

const NPC_TYPES: Array[String] = ["default", "character_1", "character_2", "character_3", "character_4", "character_5"]

var npc_type: String

func _ready():
	npc_type = NPC_TYPES[randi() % NPC_TYPES.size()]

func _physics_process(_delta):
	move_and_slide()

	if velocity.x > 0:
		animated_sprite_2d.play(npc_type + "_" + "run_right")
	elif velocity.x < 0:
		animated_sprite_2d.play(npc_type + "_" + "run_left")

	if velocity.x == 0 && velocity.y == 0:
		animated_sprite_2d.play(npc_type + "_" + "idle_down")
