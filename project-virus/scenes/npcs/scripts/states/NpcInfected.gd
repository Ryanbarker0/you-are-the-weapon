extends State
class_name NpcInfected

@export var npc_sprite: AnimatedSprite2D
@export var npc: CharacterBody2D
@export var move_speed: float = 10.0

var move_direction: Vector2
var wonder_time: float

func randomize_wonder():
	move_direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
	wonder_time = randf_range(1, 3)

func Enter():
    # Duplicate the shader material for unique instance
	var original_material : ShaderMaterial = npc_sprite.material
	var new_material : ShaderMaterial = original_material.duplicate()
	npc_sprite.material = new_material
    
    # Enabling shader and particles for infected visuals
	new_material.set_shader_parameter("shader_enabled", true)
	var spore_particles: CPUParticles2D = npc_sprite.get_children()[0]
	spore_particles.visible = true

func Update(delta: float) -> void:
	if wonder_time > 0:
		wonder_time -= delta
	else:
		randomize_wonder()
	pass

func Physics_Update(_delta: float):
	if npc:
		npc.velocity = move_direction * move_speed

