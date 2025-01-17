extends Node2D

@export var BasicNpcScene: PackedScene
@export var BasicEnemyScene: PackedScene

var margin = 150
var screen_width = ProjectSettings.get_setting("display/window/size/viewport_width")

@onready var spawner_component: SpawnerComponent = $SpawnerComponent

## Entity Timers

# NPC Timers
@onready var basic_npc_spawn_timer: Timer = $BasicNpcSpawnTimer

# Enemy Timers
@onready var basic_enemy_spawn_timer: Timer = $BasicEnemySpawnTimer

func _ready():
	basic_npc_spawn_timer.timeout.connect(handle_spawn.bind(BasicNpcScene, basic_npc_spawn_timer))
	basic_enemy_spawn_timer.timeout.connect(handle_spawn.bind(BasicEnemyScene, basic_enemy_spawn_timer))
	# Add more entity timers here for additional entity types


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
