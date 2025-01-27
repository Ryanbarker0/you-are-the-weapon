extends Node2D

@export var BasicNpcScene: PackedScene
@export var BasicEnemyScene: PackedScene

@export var game_over_screen: Control

var margin = 250
var screen_width = ProjectSettings.get_setting("display/window/size/viewport_width")

@onready var spawner_component: SpawnerComponent = $SpawnerComponent

## Entity Timers

# Game Timer
@onready var game_timer: Timer = $GameTimer
# NPC Timers
@onready var basic_npc_spawn_timer: Timer = $BasicNpcSpawnTimer
# Enemy Timers
@onready var basic_enemy_spawn_timer: Timer = $BasicEnemySpawnTimer

var phase: int = 0

func _ready():
	game_timer.timeout.connect(game_timer_timeout)
	basic_npc_spawn_timer.timeout.connect(handle_spawn.bind(BasicNpcScene, basic_npc_spawn_timer))
	basic_enemy_spawn_timer.timeout.connect(handle_spawn.bind(BasicEnemyScene, basic_enemy_spawn_timer))
	# Add more entity timers here for additional entity types

func _process(delta):
	if game_over_screen.visible:
		game_timer.stop()
		basic_npc_spawn_timer.stop()
		basic_enemy_spawn_timer.stop()

func handle_spawn(entity_scene: PackedScene, timer: Timer):
	spawner_component.scene = entity_scene
	
	var camera = get_viewport().get_camera_2d()
	var camera_position = camera.global_position
	var viewport_size = get_viewport_rect().size
	var spawn_position = Vector2()

	# Determine spawn position outside the camera window
	if randf() < 0.5:
		# Spawn on the left or right side
		if randf() < 0.5:
			spawn_position.x = camera_position.x - viewport_size.x / 2 - margin
		else:
			spawn_position.x = camera_position.x + viewport_size.x / 2 + margin
			spawn_position.y = randf_range(camera_position.y - viewport_size.y / 2 - margin, camera_position.y + viewport_size.y / 2 + margin)
	else:
		# Spawn on the top or bottom side
		spawn_position.x = randf_range(camera_position.x - viewport_size.x / 2 - margin, camera_position.x + viewport_size.x / 2 + margin)
		if randf() < 0.5:
			spawn_position.y = camera_position.y - viewport_size.y / 2 - margin
		else:
			spawn_position.y = camera_position.y + viewport_size.y / 2 + margin

	spawner_component.spawn(spawn_position)
	timer.start()

func game_timer_timeout():
	phase += 1
	if basic_npc_spawn_timer.wait_time == 5:
		basic_npc_spawn_timer.autostart = false
		basic_npc_spawn_timer.stop()
	if basic_enemy_spawn_timer.wait_time == 0.5:
		return 
	basic_npc_spawn_timer.wait_time += 0.5
	basic_enemy_spawn_timer.wait_time -= 0.5
