@export var pulse_speed: float = 2.0 # Speed of the pulsing effect
@export var min_energy: float = 0.5 # Minimum light intensity
@export var max_energy: float = 1.5 # Maximum light intensity
@export var min_range: float = 50.0 # Minimum light range
@export var max_range: float = 100.0 # Maximum light range

var pulse_time: float = 0.0 # Tracks the time for the sine wave

func _process(delta: float) -> void:
	# Increment time for pulsing
	pulse_time += delta * pulse_speed

	# Calculate a smooth pulse using a sine wave
	var pulse_value = sin(pulse_time) * 0.5 + 0.5 # Normalize sin() to 0..1

	# Interpolate energy and range
	self.energy = lerp(min_energy, max_energy, pulse_value)
	self.range = lerp(min_range, max_range, pulse_value)
