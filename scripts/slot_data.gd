extends Resource
class_name SlotData

@export var item_data: ItemData

const DroppedItem = preload("res://scenes/dropped_item.tscn")

func drop():
	var dropped_item = DroppedItem.instantiate()
	dropped_item.slot_data = self
	dropped_item.spawn_pos = Global.player.position + Vector2(0, 96)
	Global.add_child(dropped_item)
