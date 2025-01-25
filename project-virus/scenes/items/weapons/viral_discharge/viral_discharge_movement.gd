extends Projectile

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var direction = Vector2(cos(rotation), sin(rotation))
	position += direction * speed * delta
