extends Node
class_name HurtComponent

# Grab the stats so we can alter the health
@export var stats_component: StatsComponent

# Grab a hurtbox so we know when we have taken a hiet
@export var hurtbox_component: HurtboxComponent

@export var audio_player: AudioStreamPlayer
@export var hit_sound: AudioStream

func _ready() -> void:
	# Connect the hurt signal on the hurtbox component to an anonymous function
	# that removes health equal to the damage from the hitbox
	hurtbox_component.hurt.connect(func(hitbox_component: HitboxComponent):
		if audio_player && hit_sound:
			audio_player.stream = hit_sound
			audio_player.play()
		stats_component.health -= hitbox_component.damage
	)
