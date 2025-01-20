extends Node
class_name StatsComponent

# Create the health variable and connect a setter
@export var health: int = 5:
	set(value):
		health = value
		
		# Signal out that the health has changed
		health_changed.emit()
		
		# Signal out when health is at 0
		if health == 0: 
			no_health.emit()

# Create our signals for health
signal health_changed() # Emit when the health value has changed
signal no_health() # Emit when there is no health left


@export var move_speed: float = 300.0:
	set(value):
		move_speed = value

		move_speed_changed.emit()

# Create our signals for move speed
signal move_speed_changed() # Emit when the move speed value has changed
