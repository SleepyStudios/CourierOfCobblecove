extends QuestData
class_name SnakeQuest

func _get_text() -> String:
	if is_quest_started():
		return "Ssssssss"
	
	return "Sssssss...heeeere take thisssss aaaaapple"
	
func _get_options() -> Array[Dictionary]:
	return [
		{
			"action_id": "accept",
			"enabled": !is_quest_started(),
			"text": "Thanks!"
		}
	]

func _on_option_chosen(action_id: String):
	match action_id:
		"accept":
			Global.inventory_data.try_add_item("Apple")
			start_quest()
