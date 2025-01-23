extends ParallaxBackground

@export var foreground_speed = 20.0
@export var midground_speed = 10.0
@export var background_speed = 2.0

@onready var foreground_layer : ParallaxLayer = $Foreground
@onready var midground_layer: ParallaxLayer = $Midground
@onready var background_layer : ParallaxLayer = $Background

func _process(delta):
	# Update the ParallaxBackground's scroll_offset based on the foreground speed
	scroll_offset += Vector2(foreground_speed, foreground_speed) * delta
	
	# Apply motion_offset scaling for each layer relative to its specific speed
	background_layer.motion_offset = scroll_offset * (background_speed / foreground_speed)
	midground_layer.motion_offset = scroll_offset * (midground_speed / foreground_speed)
	foreground_layer.motion_offset = scroll_offset
	

