extends CharacterBody2D

@onready var animated_sprite_2d = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_infection_area_body_entered(body:Node2D):
	if body is Player:
		var material:ShaderMaterial = animated_sprite_2d.material
		material.set_shader_parameter("shader_enabled", true)
