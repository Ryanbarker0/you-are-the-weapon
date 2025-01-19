extends State
class_name NpcInfected

@export var npc_sprite: AnimatedSprite2D
@export var npc: CharacterBody2D
@export var move_speed: float = 10.0
@export var audio_stream: AudioStreamPlayer

@export var score_component: ScoreComponent

var move_direction: Vector2
var wonder_time: float
var audio_interval: float

func randomize_wonder():
	move_direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
	wonder_time = randf_range(1, 3)
	
func randomize_audio_interval():
	audio_interval = randf_range(5, 10)
	## TODO: Enable when done testing
	##audio_stream.play()

func Enter():
	score_component.adjust_score(1)
	var material : ShaderMaterial = npc_sprite.material
	
	# Enabling shader and particles for infected visuals
	material.set_shader_parameter("shader_enabled", true)
	var spore_particles: CPUParticles2D = npc_sprite.get_children()[0]
	spore_particles.visible = true

func Update(delta: float) -> void:
	if wonder_time > 0:
		wonder_time -= delta
	else:
		randomize_wonder()
	if audio_interval > 0:
		audio_interval -= delta
	else:
		randomize_audio_interval()

func Physics_Update(_delta: float):
	if npc:
		npc.velocity = move_direction * move_speed
		
