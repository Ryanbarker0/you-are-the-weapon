extends Area2D

@onready var hud: CanvasLayer = get_parent().get_node("HUD")
@onready var upgrade_panel: Control = get_parent().get_node("Menus").get_node("UpgradePanel")

func _on_body_entered(body: Node2D):
	print(upgrade_panel)
	if body is Player:
		hud.hide()
		upgrade_panel.show()
		# Load upgrade panel 
		queue_free()
