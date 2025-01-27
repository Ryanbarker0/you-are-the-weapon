extends Node
class_name ScreenShakeComponent

# Grab a hurtbox so we know when we have taken a hiet
@export var hurtbox_component: HurtboxComponent

@export var player: Player

# Called when the node enters the scene tree for the first time.
func _ready():
	hurtbox_component.hurt.connect(func(hitbox_component: HitboxComponent):
		player.camera.trigger_shake()
	)

