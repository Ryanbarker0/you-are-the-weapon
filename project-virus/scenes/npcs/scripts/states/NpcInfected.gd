extends State
class_name NpcInfected

@export var npc_sprite: AnimatedSprite2D
@export var npc: CharacterBody2D
@export var move_speed: float = 10.0
@export var audio_stream: AudioStreamPlayer
@export var deathtime: Timer
@export var score_component: ScoreComponent
@export var hurtbox_component: HurtboxComponent
@export var flash_component: FlashComponent
@export var health_bar: TextureProgressBar

const INFECTED_MATERIAL = preload("res://scenes/npcs/shaders/infected_material.tres")

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
	health_bar.hide()
	hurtbox_component.queue_free()
	flash_component.free()
	score_component.adjust_score(1)
	npc_sprite.material = INFECTED_MATERIAL.duplicate()
	
	# Enabling shader and particles for infected visuals
	npc_sprite.material.set_shader_parameter("shader_enabled", true)
	var spore_particles: CPUParticles2D = npc_sprite.get_children()[0]
	spore_particles.visible = true
	
	#Start DeadTime
	var dead_time: Timer = deathtime
	dead_time.start()

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
		

#Dead time signal emitted when timeout
func _on_dead_time_timeout() -> void:
	Transitioned.emit(self, "NpcDead")
