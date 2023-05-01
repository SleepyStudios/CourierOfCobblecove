extends QuestData
class_name FarmerQuest

func _get_text() -> String:
	if get_data("just_started"):
		return "Thank you stranger! Here, take her lead, she'll know to come home if she has this"
	
	if get_data("just_completed"):
		return "You found her! I don't know what I'd do without her, so here, take these coins"
	
	if is_quest_started():
		return "Have you found Buttercup?"
	
	if !is_quest_completed():
		return "Help! My prize cow has vanished from the pasture overnight. I fear it's been stolen by bandits or wild beasts. Please, find my cow and bring her back to me safe and sound."

	return "I know where Buttercup is now, I'll fetch her 'soon as I can"
	
func _get_options() -> Array[Dictionary]:
	if is_quest_completed(): return []

	return [
		{
			"action_id": "accept",
			"enabled": !is_quest_started(),
			"text": "I'll find her"
		},
		{
			"action_id": "complete",
			"enabled": Global.inventory_data.has_item("Buttercup's Bell"),
			"text": "[Hand over Buttercup's Bell]"
		}
	]

func _on_option_chosen(action_id: String):
	match action_id:
		"accept":
			Global.inventory_data.try_add_item("Buttercup's Lead")
			start_quest()			
		"complete":
			Global.inventory_data.remove_item("Buttercup's Bell")
			Global.inventory_data.try_add_item("Coins")
			complete_quest()

func _handle_quest_started():
	set_data("just_started", true)
	
func _handle_quest_completed(from_check: bool):
	set_data("just_completed", !from_check)
	
func _on_dialogue_closed():
	reset_data()

