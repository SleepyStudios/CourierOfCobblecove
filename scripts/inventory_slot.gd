extends PanelContainer

signal slot_clicked(index: int)
signal slot_dropped(index: int)

@onready var texture_rect = $MarginContainer/TextureRect

var _grabbed_slot: bool
var _is_hovered: bool

var _original_index: int = -1

func set_slot_data(slot_data: SlotData, grabbed_slot: bool, original_index: int = -1):
	_grabbed_slot = grabbed_slot
	_original_index = original_index
	
	if _grabbed_slot:
		z_index = 999
	
	var item_data = slot_data.item_data
	texture_rect.texture = item_data.texture
	tooltip_text = "%s\n%s" % [item_data.name, item_data.description]

func _on_gui_input(event):
	if event is InputEventMouseButton \
			and event.button_index == MOUSE_BUTTON_LEFT \
			and event.is_pressed() \
			and not _grabbed_slot:
		slot_clicked.emit(get_index())

func _on_mouse_entered():
	_is_hovered = not _grabbed_slot

func _on_mouse_exited():
	_is_hovered = false

func _process(delta):
	if Input.is_action_just_released("click") and _is_hovered:
		slot_dropped.emit(get_index())
