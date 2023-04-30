extends Resource
class_name SlotData

const MAX_STACK_SIZE: int = 99

@export var item_data: ItemData
@export_range(1, MAX_STACK_SIZE) var quantity: int = 1: set = set_quantity

const DroppedItem = preload("res://scenes/dropped_item.tscn")

func can_merge_with_slot(other_slot_data: SlotData) -> bool:
	return item_data == other_slot_data.item_data \
			and item_data.stackable \
			and quantity + other_slot_data.quantity < MAX_STACK_SIZE

func merge_with_slot(other_slot_data: SlotData):
	quantity += other_slot_data.quantity

func set_quantity(value: int):
	quantity = value
	if quantity > 1 and not item_data.stackable:
		quantity = 1
		push_error("%s is not stackable" % item_data.name)

func drop():
	var dropped_item = DroppedItem.instantiate()
	dropped_item.slot_data = self
	dropped_item.spawn_pos = Global.player.position + Vector2(0, 96)
	Global.add_child(dropped_item)
