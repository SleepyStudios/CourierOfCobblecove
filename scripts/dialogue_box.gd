extends ColorRect
class_name DialogueBox

@export var dialogue_data: DialogueData
@export var npc_name: String

const DialogueAction = preload("res://scenes/dialogue_action.tscn")

func _ready():
	for option in dialogue_data.action_options:
		var action = DialogueAction.instantiate()
		var button: Button = action.get_node("Button")
		
		button.text = option
		button.pressed.connect(func (): return self._on_button_pressed(dialogue_data.action_options.find(option)))
		action.hide()		
		$MarginContainer/VBoxContainer.add_child(action)
		
	if is_successful():
		handle_quest_completed(Global.quest_manager.get_completed_quest_action_index(npc_name), true)

func is_successful():
	return Global.quest_manager.is_quest_completed(npc_name)

func show_dialogue():
	if is_successful():
		$MarginContainer/Text.text = dialogue_data.post_success_text
	else:
		$MarginContainer/Text.text = dialogue_data.default_text
		
	toggle_options()

func toggle_options():
	for i in len(dialogue_data.action_options):
		$MarginContainer/VBoxContainer.get_child(i).visible = \
			false if is_successful() else Global.inventory_data.has_item(dialogue_data.action_requirements[i])

func _on_button_pressed(index: int):
	Global.cursor.play_anim()
	
	Global.inventory_data.remove_item(dialogue_data.action_requirements[index])
	$MarginContainer/Text.text = dialogue_data.action_success_texts[index]
	Global.quest_manager.complete_quest(npc_name, index)
	toggle_options()
	handle_quest_completed(index)

func handle_quest_completed(index: int, from_ready = false):
	print(dialogue_data.action_callbacks[index])
