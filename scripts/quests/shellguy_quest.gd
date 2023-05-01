extends QuestData
class_name ShellGuyQuest

func _get_text() -> String:
	if get_data("just_completed"):
		return "It's enchanted? I know everything there is to know about shells but I've never heard of an enchanted one before. Have this one, it makes strange noises sometimes"
	
	if is_quest_completed():
		return "I just love shells, don't you?"

	return "Hey! You! Have you seen any nice shells recently? I'll trade you for one of mine"

func _get_options() -> Array[Dictionary]:
	return [
		{
			"action_id": "trade_shell",
			"enabled": Global.inventory_data.has_item("Dull Shell"),
			"text": "[Trade Dull Shell]"
		}
	]

func _on_option_chosen(action_id: String):
	match action_id:
		"trade_shell":
			Global.inventory_data.remove_item("Dull Shell")
			Global.inventory_data.try_add_item("Shiny Shell")
			complete_quest()

func _handle_quest_completed(from_check: bool):
	set_data("just_completed", !from_check)

func _on_dialogue_closed():
	reset_data()
