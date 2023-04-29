extends Resource
class_name InventoryData

signal inventory_updated(inventory_data: InventoryData)
signal inventory_interact(inventory_data: InventoryData, index: int, event_name: String)

const INTERACTION_EVENT_SLOT_CLICKED = "slot_clicked"
const INTERACTION_EVENT_SLOT_DROPPED = "slot_dropped"

@export var slots: Array[SlotData]
var recipes: Array[RecipeData]

func _init():
	var base_path = "res://resources/recipes"
	var dir = DirAccess.open(base_path)
	dir.list_dir_begin()

	var file_name = dir.get_next()
	while file_name != "":
		if not dir.current_is_dir():
			recipes.push_back(load(base_path + "/" + file_name))
		file_name = dir.get_next()

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

func get_available_recipe(slot1: SlotData, slot2: SlotData) -> RecipeData:
	for recipe in recipes:
		if [slot1.item_data.name, slot2.item_data.name].has(recipe.item1.name) \
				and [slot1.item_data.name, slot2.item_data.name].has(recipe.item2.name):
			return recipe

	return null

func drop_slot_data(grabbed_slot_data: SlotData, index: int, original_grabbed_index: int):
	var slot_data = slots[index]
	
	if slot_data and slot_data.can_merge_with_slot(grabbed_slot_data):
		slot_data.merge_with(grabbed_slot_data)
	elif index == original_grabbed_index:
		slots[index] = grabbed_slot_data
	else:
		var temp = slots[index]
		var recipe: RecipeData = null
		
		#if slot_data and temp:
		#	recipe = get_available_recipe(slot_data, grabbed_slot_data)
		if recipe:
			slots[index].item_data = recipe.result
		else:
			slots[index] = grabbed_slot_data
			slots[original_grabbed_index] = temp

	inventory_updated.emit(self)

func pickup_item(slot_data: SlotData) -> bool:
	for i in range(0, slots.size()):
		if !slots[i]:
			slots[i] = slot_data
			inventory_updated.emit(self)			
			return true
			
	return false
