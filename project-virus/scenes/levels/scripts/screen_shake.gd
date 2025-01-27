extends Camera2D

# Screen shake parameters
@export var shake_duration: float = 0.5  # Total shake duration in seconds
@export var shake_magnitude: float = 10.0  # Magnitude of shake
@export var shake_frequency: float = 20.0  # Frequency of oscillations

var original_offset: Vector2 = Vector2.ZERO
var shake_timer: float = 0.0
var shaking: bool = false

func _ready():
	original_offset = offset

func trigger_shake():
	# Start the screen shake
	shake_timer = shake_duration
	shaking = true

func _process(delta: float):
	if shaking:
		shake_timer -= delta
		if shake_timer > 0:
			# Calculate shake offset using sine wave for smooth motion
			var shake_x = randf_range(-1, 1) * shake_magnitude
			var shake_y = randf_range(-1, 1) * shake_magnitude
			offset = original_offset + Vector2(shake_x, shake_y)
		else:
			# Reset when shake is done
			shaking = false
			shake_timer = 0
			offset = original_offset
