extends PanelContainer

signal slot_clicked(index: int)
signal slot_dropped(index: int)

@onready var texture_rect = $MarginContainer/TextureRect

var grabbed_slot: bool
var is_hovered: bool

var original_index: int = -1

func set_slot_data(slot_data: SlotData, grabbed_slot: bool, original_index: int = -1):
	self.grabbed_slot = grabbed_slot
	self.original_index = original_index
	
	if grabbed_slot:
		z_index = 999

	var item_data = slot_data.item_data
	texture_rect.texture = item_data.texture
	tooltip_text = "%s\n%s" % [item_data.name, item_data.description]

func _on_gui_input(event):
	if event is InputEventMouseButton \
			and event.button_index == MOUSE_BUTTON_LEFT \
			and event.is_pressed() \
			and not grabbed_slot:
		slot_clicked.emit(get_index())

func _on_mouse_entered():
	is_hovered = not grabbed_slot

func _on_mouse_exited():
	is_hovered = false

func _process(delta):
	if Input.is_action_just_released("click") and is_hovered:
		slot_dropped.emit(get_index())
