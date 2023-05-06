extends ColorRect
class_name DialogueBox

@export var quest_data: QuestData
@onready var v_box_container = $MarginContainer/MarginContainer/VBoxContainer
@onready var dialogue_text = $MarginContainer/MarginContainer/Text

const DialogueAction = preload("res://scenes/dialogue_action.tscn")

func _ready():
	quest_data.check_is_completed()

func _gui_input(event):
	if event.is_action_pressed("click") and visible:
		Global.player.request_hide_dialogue()

func handle_ui():
	dialogue_text.text = quest_data._get_text()
	toggle_options()

func show_dialogue():
	if visible: return
	
	show()

	quest_data._on_dialogue_opened()
	handle_ui()
	
func hide_dialogue():
	hide()
	quest_data._on_dialogue_closed()

func toggle_options():
	for child in v_box_container.get_children():
		child.queue_free()

	for option in quest_data._get_options():
		if option.enabled:
			var action = DialogueAction.instantiate()
			var button: Button = action.get_node("Button")

			button.text = option.text
			button.pressed.connect(func (): return self._on_button_pressed(option.action_id))
			v_box_container.add_child(action)

func _on_button_pressed(action_id: String):
	Global.cursor.play_anim()
	$DialogueOptionPlayer.play()

	quest_data._on_option_chosen(action_id)
	if quest_data.is_quest_completed():
		$QuestCompletePlayer.play()
		
	handle_ui()
