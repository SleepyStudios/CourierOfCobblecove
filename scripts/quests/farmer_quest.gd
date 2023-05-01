extends QuestData
class_name FarmerQuest

func _get_text() -> String:
	if just_started:
		return "Thank you stranger! Here, take her lead, she'll know to come home if she has this"
	
	if is_quest_started():
		return "Have you found Buttercup?"
	
	if !is_quest_completed():
		return "Help! My prize cow has vanished from the pasture overnight. I fear it's been stolen by bandits or wild beasts. Please, find my cow and bring her back to me safe and sound."

	return "You found her! I don't know what I'd do without her, so here, take these coins"
	
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
