extends Sprite2D


var _time = 10
var rotate_speed = 5

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_time = wrapf(_time + delta * rotate_speed, -PI,PI)
	rotation = _time
