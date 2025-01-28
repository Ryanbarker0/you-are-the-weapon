extends Node2D

@export var game_stats: GameStats

@export var BasicNpcScene: PackedScene
@export var BasicEnemyScene: PackedScene
@export var RareNpcScene: PackedScene

@export var game_over_screen: Control
@export var left_edge: Marker2D
@export var right_edge: Marker2D
@export var top_edge: Marker2D
@export var bottom_edge: Marker2D

var margin = 350
var screen_width = ProjectSettings.get_setting("display/window/size/viewport_width")

@onready var spawner_component: SpawnerComponent = $SpawnerComponent

## Entity Timers
@onready var game_timer: Timer = $GameTimer
@onready var basic_npc_spawn_timer: Timer = $BasicNpcSpawnTimer
@onready var rare_npc_spawn_timer: Timer = $RareNpcSpawnTimer
@onready var basic_enemy_spawn_timer: Timer = $BasicEnemySpawnTimer

var phase: int = 0

func _ready():
	game_timer.timeout.connect(game_timer_timeout)
	basic_npc_spawn_timer.timeout.connect(handle_spawn.bind(BasicNpcScene, basic_npc_spawn_timer, "basic_npc"))
	rare_npc_spawn_timer.timeout.connect(handle_spawn.bind(RareNpcScene, rare_npc_spawn_timer, "rare_npc"))
	basic_enemy_spawn_timer.timeout.connect(handle_spawn.bind(BasicEnemyScene, basic_enemy_spawn_timer, "basic_enemy"))

func _process(delta):
	if game_over_screen.visible:
		game_timer.stop()
		rare_npc_spawn_timer.stop()
		basic_npc_spawn_timer.stop()
		basic_enemy_spawn_timer.stop()

func handle_spawn(entity_scene: PackedScene, timer: Timer, entity_name: String):
	spawner_component.scene = entity_scene
	
	var camera = get_viewport().get_camera_2d()
	var camera_position = camera.global_position
	var viewport_size = get_viewport_rect().size

	var spawn_position = get_spawn_position_just_outside_viewport(camera_position, viewport_size)

	# Only spawn if spawn_position is valid
	if is_valid_spawn_position(spawn_position):
		if entity_name == "rare_npc":
			if game_stats.current_rare_npc == 3:
				timer.wait_time = randf_range(3, 5)
				timer.start()
				return
			else:
				spawner_component.spawn(spawn_position)
				game_stats.current_rare_npc +=1
		else:
			spawner_component.spawn(spawn_position)

	if entity_name == "rare_npc":
		timer.wait_time = randf_range(15, 30)
	timer.start()

func get_spawn_position_just_outside_viewport(camera_position: Vector2, viewport_size: Vector2) -> Vector2:
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

	return spawn_position

func is_valid_spawn_position(pos: Vector2) -> bool:
	# Check if the spawn position is within the bounds set by edge markers
	return pos.x >= left_edge.global_position.x and pos.x <= right_edge.global_position.x and pos.y >= top_edge.global_position.y and pos.y <= bottom_edge.global_position.y

func game_timer_timeout():
	phase += 1
	# Once npc spawner hits phase 10 stop spawning basic npcs
	if basic_npc_spawn_timer.wait_time == 5 && phase == 10:
		basic_npc_spawn_timer.autostart = false
		basic_npc_spawn_timer.stop()
	if basic_enemy_spawn_timer.wait_time == 0.5:
		return

	basic_npc_spawn_timer.wait_time += 0.5
	basic_enemy_spawn_timer.wait_time -= 0.5
	
	# Only spawn enemies after phase 2	
	if phase == 2:
		basic_enemy_spawn_timer.wait_time = 5
		basic_enemy_spawn_timer.start()
