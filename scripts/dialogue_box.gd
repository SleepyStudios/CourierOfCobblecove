extends ColorRect
class_name DialogueBox

@export var dialogue_data: DialogueData

const DialogueAction = preload("res://scenes/dialogue_action.tscn")

var success: bool

func _ready():
	for option in dialogue_data.action_options:
		var action = DialogueAction.instantiate()
		var button: Button = action.get_node("Button")
		
		button.text = option
		button.pressed.connect(func (): return self._on_button_pressed(dialogue_data.action_options.find(option)))
		action.hide()		
		$MarginContainer/VBoxContainer.add_child(action)

func show_dialogue():
	if success:
		$MarginContainer/Text.text = dialogue_data.post_success_text
	else:
		$MarginContainer/Text.text = dialogue_data.default_text
		
	toggle_options()

func toggle_options():
	for i in len(dialogue_data.action_options):
		$MarginContainer/VBoxContainer.get_child(i).visible = \
			false if success else Global.inventory_data.has_item(dialogue_data.action_requirements[i])

func _on_button_pressed(index: int):
	Global.inventory_data.remove_item_by_name(dialogue_data.action_requirements[index])
	$MarginContainer/Text.text = dialogue_data.action_success_texts[index]
	success = true
	toggle_options()
