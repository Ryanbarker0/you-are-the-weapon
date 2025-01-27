extends Sprite2D

var tween: Tween

func _ready():
	animate_sprite()

func _restart_tween():
	animate_sprite()	

func animate_sprite():
	tween = get_tree().create_tween()
	tween.bind_node(self)
	tween.set_loops(-1)

	# Bobbing animation (up and down)
	tween.tween_property(self, "position:y", position.y - 5, 0.2) \
		.set_trans(Tween.TRANS_SINE) \
		.set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, "position:y", position.y + 5, 0.2) \
		.set_trans(Tween.TRANS_SINE) \
		.set_ease(Tween.EASE_IN_OUT)
