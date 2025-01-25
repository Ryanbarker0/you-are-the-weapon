extends Button

func on_button_pressed():
	var player = get_parent().get_node("ySort").get_node("Player")
	# Add a rotating_persistent_projectile scene as a child of the Player scene
	var rotating_persistent_projectile: PackedScene = load("res://scenes/player/weapons/rotating_persistent_projectile.tscn")
	var instance = rotating_persistent_projectile.instantiate()
	player.add_child(instance)
