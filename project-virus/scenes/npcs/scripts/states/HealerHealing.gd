extends State
class_name HealerHealing

@export var healer: CharacterBody2D
@export var healing_animation: AnimatedSprite2D
@export var character_animation: AnimatedSprite2D

var move_direction: Vector2
var wonder_time: float

var current_npc: NPC

signal healing_complete

func Enter():
	healer.velocity = Vector2.ZERO
	character_animation.stop()
	character_animation.play("heal_left")
	character_animation.animation_finished.connect(on_animation_finished)

func Update(_delta: float) -> void:
	pass

func Physics_Update(_delta: float):
	pass

# Class Specific Functions
func on_animation_finished():
	healing_animation.hide()
	character_animation.animation_finished.disconnect(on_animation_finished)
	healing_complete.emit()
	Transitioned.emit(self, "HealerIdle")
