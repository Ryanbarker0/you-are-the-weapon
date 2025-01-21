extends State
class_name NpcInfected

@export var move_speed: float = 10.0
@export var npc: CharacterBody2D
@export var npc_sprite: AnimatedSprite2D
@export var audio_stream: AudioStreamPlayer
@export var proximity_area: Area2D
@export var death_timer: Timer
@export var score_component: ScoreComponent
@export var scan_component: ScanComponent

var move_direction: Vector2
var wonder_time: float
var audio_interval: float
var current_healer: Healer

func Enter():
	score_component.adjust_score(1)
	update_shader_and_particles()
	scan_component.enabled = true
	scan_component.body_detected.connect(on_healer_detected)
	death_timer.start()

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

# State Specific Functions
func update_shader_and_particles(on: bool = true):
	var material : ShaderMaterial = npc_sprite.material
	material.set_shader_parameter("shader_enabled", on)
	var spore_particles: CPUParticles2D = npc_sprite.get_children()[0]
	spore_particles.visible = on	

func randomize_wonder():
	move_direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
	wonder_time = randf_range(1, 3)

func randomize_audio_interval():
	audio_interval = randf_range(5, 10)
	## TODO: Enable when done testing
	##audio_stream.play()

# Signals
func _on_dead_time_timeout() -> void:
	Transitioned.emit(self, "NpcDead")

func on_healer_detected(body: Node2D):
	## Also need a way to see if the healer is interacting with this NPC
	if body.get_node("StateMachine").current_state is HealerHeal:
		scan_component.enabled = false
		scan_component.body_detected.disconnect(on_healer_detected)
		var healing_state : HealerHealing = body.get_node("StateMachine").get_node("HealerHealing")
		healing_state.healing_complete.connect(on_healing_complete)

func on_healing_complete():
	death_timer.stop()
	update_shader_and_particles(false)
	score_component.adjust_score(-1)
	Transitioned.emit(self, "NpcIdle")


