extends PanelContainer

signal on_item_dropped()

const Slot = preload("res://scenes/inventory_slot.tscn")

@onready var item_grid = $ItemGrid

func set_inventory_data(inventory_data: InventoryData):
	inventory_data.inventory_updated.connect(populate_item_grid)
	populate_item_grid(inventory_data)

func populate_item_grid(inventory_data: InventoryData) -> void:
	for child in item_grid.get_children():
		child.queue_free()
		
	for slot_data in inventory_data.slots:
		var slot = Slot.instantiate()
		item_grid.add_child(slot)
		
		slot.slot_clicked.connect(inventory_data._on_slot_clicked)
		slot.slot_dropped.connect(inventory_data._on_slot_dropped)
		
		if slot_data:
			slot.set_slot_data(slot_data, false)

func _process(delta):
	if Input.is_action_just_released("click") \
			and not get_global_rect().has_point(get_global_mouse_position()):
		on_item_dropped.emit()
