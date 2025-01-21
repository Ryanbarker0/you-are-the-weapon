extends CharacterBody2D
class_name Healer

@onready var animated_sprite_2d = $CharacterAnimation
@onready var current_state: State = $StateMachine.current_state