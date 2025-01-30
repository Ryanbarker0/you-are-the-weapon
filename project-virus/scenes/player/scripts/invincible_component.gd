extends Node

@export var hurtbox_component: HurtboxComponent
@export var timer: Timer


# Called when the node enters the scene tree for the first time.
func _ready():
	timer.timeout.connect(on_timer_timeout)
	hurtbox_component.hurt.connect(on_hurt)
	
func on_hurt(_arg):
	hurtbox_component.is_invincible = true
	timer.start()

func on_timer_timeout():
	hurtbox_component.is_invincible = false
