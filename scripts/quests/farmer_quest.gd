extends QuestData
class_name FarmerQuest

func _get_text() -> String:
	if get_data("just_started"):
		return "Thank you stranger! Here, take this carrot, she'll know it came from home"
	
	if get_data("just_completed"):
		return "You found her! I don't know what I'd do without her, so here, take these coins"
	
	if is_quest_started():
		return "Have you found Buttercup?"
	
	if !is_quest_completed():
		return "Help! My prize cow has vanished from the pasture overnight. I fear it's been stolen by bandits or wild beasts. Please, find my cow and bring her back to me safe and sound."

	return "It's a hard life being a farmer"
	
func _get_options() -> Array[Dictionary]:
	if is_quest_completed(): return []

	return [
		{
			"action_id": "accept",
			"enabled": !is_quest_started(),
			"text": "I'll find her"
		}
	]

func _on_option_chosen(action_id: String):
	match action_id:
		"accept":
			Global.inventory_data.try_add_item("Carrot")
			start_quest()			

func _handle_quest_started():
	set_data("just_started", true)
	
func _handle_quest_completed(from_check: bool):
	if not from_check:
		set_data("just_completed", true)		
		Global.inventory_data.try_add_item("Coins")		
	
func _on_dialogue_opened():
	if not is_quest_completed() and Global.quest_manager.is_quest_completed("Buttercup"):
		complete_quest()

func _on_dialogue_closed():
	reset_data()

