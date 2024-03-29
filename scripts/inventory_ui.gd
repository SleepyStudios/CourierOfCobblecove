extends Control

var grabbed_slot_data: SlotData

@onready var player_inventory = $PlayerInventory
@onready var grabbed_slot = $GrabbedSlot

func _ready():
	Global.inventory_data.inventory_interact.connect(_on_inventory_interact)
	player_inventory.set_inventory_data(Global.inventory_data)
	player_inventory.on_item_dropped.connect(_on_inventory_item_dropped)

func _on_inventory_interact(inventory_data: InventoryData, index: int, event_name: String):
	match [grabbed_slot_data, event_name]:
		[null, InventoryData.INTERACTION_EVENT_SLOT_CLICKED]:
			grabbed_slot_data = inventory_data.grab_slot_data(index)
		[_, InventoryData.INTERACTION_EVENT_SLOT_DROPPED]:
			inventory_data.drop_slot_data(grabbed_slot_data, index, grabbed_slot.original_index)
			grabbed_slot_data = null
		
	update_grabbed_slot(index)
	
func _on_inventory_item_dropped():
	if grabbed_slot_data:
		grabbed_slot_data.drop()
		grabbed_slot_data = null
		update_grabbed_slot()

func _physics_process(delta):
	if grabbed_slot.visible:
		grabbed_slot.global_position = get_global_mouse_position() - Vector2(24, 32)

func play_sfx():
	$DropPlayer.pitch_scale = RandomNumberGenerator.new().randf_range(0.9, 1.1)
	$DropPlayer.play()	

func update_grabbed_slot(index: int = -1):
	if grabbed_slot_data:
		grabbed_slot.show()
		grabbed_slot.set_slot_data(grabbed_slot_data, true, index)
		Global.cursor.start_dragging()
	else:
		grabbed_slot.hide()
		Global.cursor.stop_dragging()

	play_sfx()
