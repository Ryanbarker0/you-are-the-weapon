####################################################
# Tools are sick. The code in this script is treated
# nearly the same as if the game is running. The one
# difference is we can do Engine.is_editor_hint() to
# find out if we're currently in the editor
# Docs: https://docs.godotengine.org/en/stable/tutorials/plugins/running_code_in_the_editor.html#how-to-use-tool
####################################################
@tool
extends Area2D

@export var sprite : AnimatedSprite2D
@export var player_upgrade : BasePlayerUpgrade:
	set(val):
		player_upgrade = val
		needs_update = true

# Used when editing to denote that the sprite has changed and needs updating
@export var needs_update := false




		
func _on_body_entered(body):
	print ("picked up item", body)
	if body is Player:
		body.upgrades.append(player_upgrade)
		queue_free()
