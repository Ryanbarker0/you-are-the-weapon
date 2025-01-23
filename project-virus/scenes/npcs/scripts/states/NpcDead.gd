extends State
class_name NpcDead

@export var npc: CharacterBody2D
@export var move_speed: float = 0.0
@export var death_animation: AnimationPlayer

var move_direction: Vector2
var wonder_time: float

var death_particles_have_emitted: bool = false

func Enter():
	death_animation.play("rotate_and_explode")
	death_animation.animation_finished.connect(_on_animation_finished)

func Physics_Update(_delta: float):
	if npc:
		npc.velocity = move_direction * move_speed

func _on_animation_finished(_name):
	npc.queue_free()
