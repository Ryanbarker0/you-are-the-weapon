extends Sprite2D

var animation_time: float = 0.0

func _process(delta: float) -> void:
	animation_time += delta
	material.set_shader_parameter("time", animation_time)
