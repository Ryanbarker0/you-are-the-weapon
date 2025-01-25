extends TextureProgressBar

@export var stats_component: StatsComponent

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if stats_component:
		self.value = stats_component.health
