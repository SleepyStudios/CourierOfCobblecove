extends QuestData
class_name BeeHiveQuest

func _get_text() -> String:
	return "Bzzzzz. Bzzzzzzzzz"
	
func _get_options() -> Array[Dictionary]:
	return [
		{
			"action_id": "complete",
			"enabled": Global.inventory_data.has_item('"Best" Stick') and not is_quest_started(),
			"text": "[Poke the hive]"
		}
	]

func _on_option_chosen(action_id: String):
	match action_id:
		"complete":
			Global.inventory_data.try_add_item("Honey")
			start_quest()
