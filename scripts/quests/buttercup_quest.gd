extends QuestData
class_name ButtercupQuest

func _get_text() -> String:
	if get_data("lead_given", true):
		return "Moo?"
		
	return "Moooooo"
	
func _get_options() -> Array[Dictionary]:
	if is_quest_completed(): return []

	return [
		{
			"action_id": "get_bell",
			"enabled": Global.inventory_data.has_item("Buttercup's Lead"),
			"text": "[Give Buttercup her lead]"
		}
	]

func _handle_quest_started():
	pass

func _handle_quest_completed(from_check: bool):
	pass
	
func _on_option_chosen(action_id: String):
	match action_id:
		"get_bell":
			set_data("lead_given", true)
			Global.inventory_data.remove_item("Buttercup's Lead")
			Global.inventory_data.try_add_item("Buttercup's Bell")
