extends Node
class_name ScanComponent

@export var area_to_scan: Area2D
@export_enum("Healer", "Player", "Npc", "Enemy") var body_to_scan_for: String

var enabled = false

signal body_detected(body: Node2D)

func _process(_delta):
	if enabled:
		var bodies_in_proximity = area_to_scan.get_overlapping_bodies()
		for body in bodies_in_proximity:
			match body_to_scan_for:
				"Healer":
					if body is Healer:
						body_detected.emit(body)
				"Player":
					if body is Player:
						body_detected.emit(body)
				"Npc":
					if body is NPC:
						body_detected.emit(body)
				"Enemy":
					if body is Enemy:
						body_detected.emit(body)
