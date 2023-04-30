extends ColorRect
class_name DialogueBox

@export var dialogue_data: DialogueData
@export var npc: NPC

const DialogueAction = preload("res://scenes/dialogue_action.tscn")

var quest_already_completed: bool

func _ready():
	for option in dialogue_data.action_options:
		var action = DialogueAction.instantiate()
		var button: Button = action.get_node("Button")
		
		button.text = option
		button.pressed.connect(func (): return self._on_button_pressed(dialogue_data.action_options.find(option)))
		action.hide()		
		$MarginContainer/VBoxContainer.add_child(action)
		
	if is_successful():
		handle_quest_completed(Global.quest_manager.get_completed_quest_action_index(npc.name), true)

func is_successful():
	return Global.quest_manager.is_quest_completed(npc.name)

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
	Global.quest_manager.complete_quest(npc.name, index)
	toggle_options()
	handle_quest_completed(index)

func handle_quest_completed(index: int, from_ready = false):
	quest_already_completed = from_ready
	
	if dialogue_data.action_callbacks[index].is_empty():
		return

	for line in dialogue_data.action_callbacks[index].split('\n'):
		var parts = line.split(',')
		callv("_action_callback_" + parts[0], parts.slice(1))

func _action_callback_add_item(item_name: String):
	if quest_already_completed: return
	Global.inventory_data.try_add_item(item_name)
	
func _action_callback_play_anim(anim_name: String):
	npc.animation.play(anim_name)

