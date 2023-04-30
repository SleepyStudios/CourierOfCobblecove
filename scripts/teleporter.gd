extends Node2D

@export var zone: String
@export_enum("Left", "Right", "Top", "Bottom") var anchor: String

func _on_area_2d_body_entered(body):
	body.set_process(false)
	Global.go_to_zone(zone, anchor)
