extends Sprite2D

var _time := 0.0
@export var speed := 1.0

func _process(delta):
	_time = wrapf(_time + delta * speed, -PI,PI)
	rotation = _time
