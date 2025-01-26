extends Control

const WEAPON_DATA_PATH = "res://scenes/items/weapon_data.json"

# Player
@onready var player: CharacterBody2D = get_parent().get_parent().get_node("ySort/Player")

@onready var hud: CanvasLayer = get_parent().get_parent().get_node("HUD")

# Main containers
@onready var upgrade_1: PanelContainer = $MarginContainerRoot/MarginContainer/HBoxContainer/UpgradeOne
@onready var upgrade_2: PanelContainer = $MarginContainerRoot/MarginContainer/HBoxContainer/UpgradeTwo
@onready var upgrade_3: PanelContainer = $MarginContainerRoot/MarginContainer/HBoxContainer/UpgradeThree

# Textures
@onready var upgrade_1_texture: TextureRect = $MarginContainerRoot/MarginContainer/HBoxContainer/UpgradeOne/MarginContainer/VBoxContainer/TextureRect
@onready var upgrade_2_texture: TextureRect = $MarginContainerRoot/MarginContainer/HBoxContainer/UpgradeTwo/MarginContainer/VBoxContainer/TextureRect
@onready var upgrade_3_texture: TextureRect = $MarginContainerRoot/MarginContainer/HBoxContainer/UpgradeThree/MarginContainer/VBoxContainer/TextureRect

# Names
@onready var upgrade_1_label: Label = $MarginContainerRoot/MarginContainer/HBoxContainer/UpgradeOne/MarginContainer/VBoxContainer/Title
@onready var upgrade_2_label: Label = $MarginContainerRoot/MarginContainer/HBoxContainer/UpgradeTwo/MarginContainer/VBoxContainer/Title
@onready var upgrade_3_label: Label = $MarginContainerRoot/MarginContainer/HBoxContainer/UpgradeThree/MarginContainer/VBoxContainer/Title

# Descriptions
@onready var upgrade_1_rich_text_label: RichTextLabel = $MarginContainerRoot/MarginContainer/HBoxContainer/UpgradeOne/MarginContainer/VBoxContainer/RichTextLabel
@onready var upgrade_2_rich_text_label: RichTextLabel = $MarginContainerRoot/MarginContainer/HBoxContainer/UpgradeTwo/MarginContainer/VBoxContainer/RichTextLabel
@onready var upgrade_3_rich_text_label: RichTextLabel = $MarginContainerRoot/MarginContainer/HBoxContainer/UpgradeThree/MarginContainer/VBoxContainer/RichTextLabel

# Selection buttons
@onready var upgrade_1_button: Button = $MarginContainerRoot/MarginContainer/HBoxContainer/UpgradeOne/Selection
@onready var upgrade_2_button: Button = $MarginContainerRoot/MarginContainer/HBoxContainer/UpgradeTwo/Selection
@onready var upgrade_3_button: Button = $MarginContainerRoot/MarginContainer/HBoxContainer/UpgradeThree/Selection

var parsed_json: Array

var upgrade_1_scene: PackedScene
var upgrade_2_scene: PackedScene
var upgrade_3_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	await read_json_file(WEAPON_DATA_PATH)
	self.draw.connect(overlay_shown)
	upgrade_1_button.pressed.connect(on_selection_one_pressed)
	upgrade_2_button.pressed.connect(on_selection_two_pressed)
	upgrade_3_button.pressed.connect(on_selection_three_pressed)

func _process(delta):
	pass

func _populate_upgrade_panels():
	# Files are stored at res://scenes/items/weapons/<weapon_name>/
	# Each data element is like this
	# 	{
	# 	"name": "Contagion's Orbit",
	# 	"description": "A weapon that releases a contagious virus that spreads to nearby enemies.",
	# 	"damage_min": 50,
	# 	"damage_max": 60,
	# 	"scene_ref": "contaigions_orbit",
	# 	"texture_ref": "contagions_orbit_sprite.png",
	# },
	var weapon_data = parsed_json
	var weapon_1 = weapon_data[0]
	var weapon_1_texture_path = get_item_sprite_path(weapon_1["scene_ref"])
	var weapon_1_scene_path = get_item_scene_path(weapon_1["scene_ref"])

	upgrade_1_scene = load(weapon_1_scene_path)
	upgrade_1_texture.texture = load(weapon_1_texture_path)
	upgrade_1_label.text = weapon_1["name"]
	upgrade_1_rich_text_label.text = "Damage: " + "[color=red]" + str(weapon_1["damage_min"]) + "[/color]" + " - " + "[color=red]" + str(weapon_1["damage_max"]) + "[/color]" + "\n" + "\n" + weapon_1["description"]

	var weapon_2 = weapon_data[1]
	var weapon_2_texture_path = get_item_sprite_path(weapon_2["scene_ref"])
	var weapon_2_scene_path = get_item_scene_path(weapon_2["scene_ref"])

	upgrade_2_scene = load(weapon_2_scene_path)
	upgrade_2_texture.texture = load(weapon_2_texture_path)
	upgrade_2_label.text = weapon_2["name"]
	upgrade_2_rich_text_label.text = "Damage: " + "[color=red]" + str(weapon_2["damage_min"]) + "[/color]" + " - " + "[color=red]" + str(weapon_2["damage_max"]) + "[/color]" + "\n" + "\n" + weapon_2["description"]

	var weapon_3 = weapon_data[2]
	var weapon_3_texture_path = get_item_sprite_path(weapon_3["scene_ref"])
	var weapon_3_scene_path = get_item_scene_path(weapon_3["scene_ref"])

	upgrade_3_scene = load(weapon_3_scene_path)
	upgrade_3_texture.texture = load(weapon_3_texture_path)
	upgrade_3_label.text = weapon_3["name"]
	upgrade_3_rich_text_label.text = "Damage: " + "[color=red]" + str(weapon_3["damage_min"]) + "[/color]" + " - " + "[color=red]" + str(weapon_3["damage_max"]) + "[/color]" + "\n" + "\n" + weapon_3["description"]

# Helpers
func get_item_sprite_path(item_name: String):
	return "res://scenes/items/weapons/" + item_name + "/" + item_name + "_sprite.png"

func get_item_scene_path(item_name: String):
	return "res://scenes/items/weapons/" + item_name + "/" + item_name + ".tscn"

func complete_upgrade():
	hide()
	get_tree().paused = false
	hud.show()

# Signals
func overlay_shown():
	_populate_upgrade_panels()

func on_selection_one_pressed():
	var instance = upgrade_1_scene.instantiate()
	player.add_child(instance)
	complete_upgrade()

func on_selection_two_pressed():
	var projectile_spawner = load("res://scenes/items/projectile_spawner.gd")
	var viral_discharge_behaviour = load("res://scenes/items/weapons/viral_discharge/viral_discharge.gd")
	var instance: ProjectileSpawner = projectile_spawner.new()
	instance.behaviour_controller = viral_discharge_behaviour.new()
	player.add_child(instance)
	complete_upgrade()

func on_selection_three_pressed():
	var projectile_spawner = load("res://scenes/items/projectile_spawner.gd")
	var noxious_spread_behaviour = load("res://scenes/items/weapons/noxious_spread/noxious_spread.gd")
	var instance: ProjectileSpawner = projectile_spawner.new()
	instance.behaviour_controller = noxious_spread_behaviour.new()
	player.add_child(instance)
	complete_upgrade()

func read_json_file(file: String):
	var json_as_text = FileAccess.get_file_as_string(file)
	var json_as_dict = JSON.parse_string(json_as_text)
	if json_as_dict:
		parsed_json = json_as_dict
