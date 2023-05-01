extends QuestData
class_name WizardQuest

func _get_text() -> String:
	if get_data("just_started"):
		return "No no no. I have been on my own quest, you see. Deliver these potions to your fellow countrymen up north - and be quick!"
	
	if is_quest_started():
		return "Ah, you again. You seem to be appearing more frequently now, peculiar..."
	
	return "Oh? Yes? Yes! You must be the messenger. I've waited weeks for you! I was beginning to think you had been eviscerated by a demon"
	
func _get_options() -> Array[Dictionary]:
	return [
		{
			"action_id": "accept",
			"enabled": !is_quest_started(),
			"text": "Not exactly..."
		}
	]

func _on_option_chosen(action_id: String):
	match action_id:
		"accept":
			Global.inventory_data.try_add_item("Mysterious Potion")
			Global.inventory_data.try_add_item("Mysterious Potion")
			start_quest()

func _handle_quest_started():
	set_data("just_started", true)

func _on_dialogue_closed():
	reset_data()
