extends HBoxContainer

func _ready():
	for upgrade in get_children():
		var control = upgrade.get_node("MarginContainer/VBoxContainer/Control")
		var particles = control.get_node("GPUParticles2D")
		if particles:
			particles.position = control.size / 2
