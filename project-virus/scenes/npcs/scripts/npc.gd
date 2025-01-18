extends CharacterBody2D

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var spore_particles: CPUParticles2D = $AnimatedSprite2D/SporeParticles2D

func _physics_process(_delta):
	move_and_slide()

func _on_infection_area_body_entered(body:Node2D):
	if body is Player:
		var material:ShaderMaterial = animated_sprite_2d.material
		material.set_shader_parameter("shader_enabled", true)
		spore_particles.visible = true
