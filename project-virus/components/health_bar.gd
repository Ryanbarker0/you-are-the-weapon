extends TextureProgressBar

@export var stats_component: StatsComponent

var max_health: int

func _ready():
	if Globals.enable_health_bars:
		visible = true
	else:
		visible = false
	value = stats_component.health
	max_value = stats_component.health

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if stats_component:
		value = stats_component.health
