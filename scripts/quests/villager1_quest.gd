extends QuestData
class_name VillagerOneQuest

func _get_text() -> String:
	if get_data("just_completed"):
		return "The potion I... asked for. It's all coming back to me now"

	return "Flee! Flee stranger! We're doomed! We're cursed!"
	
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
