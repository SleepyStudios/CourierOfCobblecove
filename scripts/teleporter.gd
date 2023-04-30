extends Node2D

@export var zone: String

func _on_area_2d_body_entered(body):
	body.set_process(false)
	Global.go_to_zone(zone)
