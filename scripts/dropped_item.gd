extends Node2D

@export var slot_data: SlotData
@export var spawn_pos: Vector2

@onready var sprite_2d = $Sprite2D

var can_pick_up: bool

func _ready():
	sprite_2d.texture = slot_data.item_data.texture
	position = spawn_pos

func _on_area_2d_body_entered(body):
	if can_pick_up: #todo check if player
		if Global.inventory_data.pickup_item(slot_data):
			queue_free()

func _on_ready_timer_timeout():
	can_pick_up = true
