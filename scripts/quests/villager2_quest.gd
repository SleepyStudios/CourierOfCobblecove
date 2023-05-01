extends QuestData
class_name VillagerTwoQuest

func _get_text() -> String:
	if get_data("just_completed"):
		return "What's this? Well, if it's from the wizard, I suppose I should take it"

	return "Oi, listen up. There's a demon causing mayhem to the east. You best stay clear of it, unless you fancy being swept away"
	
func _get_options() -> Array[Dictionary]:
	return [
		{
			"action_id": "give_potion",
			"enabled": not is_quest_completed() and Global.inventory_data.has_item("Mysterious Potion"),
			"text": "[Hand over potion]"
		}
	]

func _on_option_chosen(action_id: String):
	match action_id:
		"give_potion":
			Global.inventory_data.remove_item("Mysterious Potion")
			complete_quest()

func _handle_quest_completed(from_check: bool):
	set_data("just_completed", !from_check)

func _on_dialogue_closed():
	reset_data()
