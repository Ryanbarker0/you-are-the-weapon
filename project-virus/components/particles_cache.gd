extends Node

var aoe = preload("res://scenes/particles/aoe.tres")
var contagion = preload("res://scenes/particles/contagion.tres")
var contagions_scene = preload("res://scenes/particles/contagions_scene.tres")
var discharge = preload("res://scenes/particles/discharge.tres")
var noxious_scene = preload("res://scenes/particles/noxious_scene.tres")
var npc_rare_shine = preload("res://scenes/particles/npc_rare_shine.tres")
var spread = preload("res://scenes/particles/spread.tres")
var viral_explosion = preload("res://scenes/particles/viral_explosion.tres")
var viral_scene = preload("res://scenes/particles/viral_scene.tres")

var materials = [
	aoe,
	contagion,
	contagions_scene,
	discharge,
	noxious_scene,
	npc_rare_shine,
	spread,
	viral_explosion,
	viral_scene
]

func _ready():
	for material in materials:
		var particles_instance = GPUParticles2D.new()
		particles_instance.set_process_material(material)
		particles_instance.set_one_shot(true)
		particles_instance.set_modulate(Color(1, 1, 1, 0))
		particles_instance.set_emitting(false)
		self.add_child(particles_instance)

