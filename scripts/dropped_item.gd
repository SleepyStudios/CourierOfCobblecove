@tool

extends Node2D
class_name DroppedItem

@export var slot_data: SlotData
@export var spawn_pos: Vector2
@export var drop_id: String

@onready var sprite_2d = $Sprite2D

var can_pick_up: bool
var picked_up: bool
var comes_with_scene: bool

func _ready():
	sprite_2d.texture = slot_data.item_data.texture
	comes_with_scene = spawn_pos == Vector2()

	if not comes_with_scene:
		position = spawn_pos
		
	drop_id = "%s-%s-%s" % [slot_data.item_data.name, position.x, position.y]

	Global.register_dropped_item(self)		

func _on_area_2d_body_entered(body):
	if can_pick_up:
		if Global.inventory_data.pickup_item(slot_data):
			Global.unregister_dropped_item(self)			
			queue_free()

func _on_ready_timer_timeout():
	can_pick_up = true

func _process(delta):
	if not sprite_2d.texture and slot_data and slot_data.item_data and Engine.is_editor_hint():
		sprite_2d.texture = slot_data.item_data.texture		
