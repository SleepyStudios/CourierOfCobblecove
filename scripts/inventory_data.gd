extends Resource
class_name InventoryData

signal inventory_updated(inventory_data: InventoryData)
signal inventory_interact(inventory_data: InventoryData, index: int, event_name: String)

const INTERACTION_EVENT_SLOT_CLICKED = "slot_clicked"
const INTERACTION_EVENT_SLOT_DROPPED = "slot_dropped"

@export var slots: Array[SlotData]

func _on_slot_clicked(index: int):
	inventory_interact.emit(self, index, INTERACTION_EVENT_SLOT_CLICKED)
	
func _on_slot_dropped(index: int):
	inventory_interact.emit(self, index, INTERACTION_EVENT_SLOT_DROPPED)

func grab_slot_data(index: int) -> SlotData:
	var slot_data = slots[index]
	if slot_data:
		slots[index] = null
		inventory_updated.emit(self)
		return slot_data
	else:
		return null

func drop_slot_data(grabbed_slot_data: SlotData, index: int, original_grabbed_index: int):
	var slot_data = slots[index]
	
	if slot_data and slot_data.can_merge_with_slot(grabbed_slot_data):
		slot_data.merge_with(grabbed_slot_data)
	elif index == original_grabbed_index:
		slots[index] = grabbed_slot_data
	else:
		var temp = slots[index]
		slots[index] = grabbed_slot_data
		slots[original_grabbed_index] = temp

	inventory_updated.emit(self)
