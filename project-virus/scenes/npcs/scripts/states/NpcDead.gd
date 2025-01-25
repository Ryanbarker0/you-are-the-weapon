extends State
class_name NpcDead

@export var npc: CharacterBody2D
@export var move_speed: float = 0.0
@export var death_animation: AnimationPlayer

var upgrade_item: PackedScene = preload("res://scenes/items/upgrade_item.tscn")

var move_direction: Vector2
var wonder_time: float

func Enter():
	death_animation.play("rotate_and_explode")
	death_animation.animation_finished.connect(_on_animation_finished)

func Physics_Update(_delta: float):
	if npc:
		npc.velocity = move_direction * move_speed

func _on_animation_finished(_name):
	## add upgrade item to parent scene
	var upgrade_item_instance = upgrade_item.instantiate()
	upgrade_item_instance.global_position = npc.global_position
	npc.get_parent().get_parent().add_child(upgrade_item_instance)
	npc.queue_free()
