extends Area2D
class_name HitboxComponent

# Export the damage amount this hitbox deals
@export var damage = 1.0

# Create a signal for when the hitbox hits a hurtbox
signal hit_hurtbox(hurtbox)

func _ready():
	# Connect on area entered to our hurtbox entered function
	area_entered.connect(_on_hurtbox_entered)
	
func _on_hurtbox_entered(hurtbox: Area2D):
	# Make sure the area we are overlapping is a hurtbox
	if !hurtbox is HurtboxComponent: 
		return
	# Make sure the hurtbox isn't invincible
	if hurtbox.is_invincible: 
		return
	# Signal out that we hit a hurtbox (this is useful for destroying projectiles when they hit something)
	hit_hurtbox.emit(hurtbox)
	# Have the hurtbox signal out that it was hit
	hurtbox.hurt.emit(self)