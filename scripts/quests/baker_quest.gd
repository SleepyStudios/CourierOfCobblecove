extends QuestData
class_name BakerQuest

func _get_text() -> String:
	if get_data("just_completed"):
		return "From a mermaid you say? No no... I don't think we could make it work. While love is in the air though, please, take these flowers to my beloved guarding the castle. Tell her only that it's from her secret admirer"

	return "Have you come seeking my artisan buns?"
	
func _get_options() -> Array[Dictionary]:
	return [
		{
			"action_id": "give_necklace",
			"enabled": Global.inventory_data.has_item("Shell Necklace"),
			"text": "[Hand over the necklace]"
		}
	]

func _on_option_chosen(action_id: String):
	match action_id:
		"give_necklace":
			Global.inventory_data.remove_item("Shell Necklace")
			Global.inventory_data.try_add_item("Flowers")
			complete_quest()

func _handle_quest_completed(from_check: bool):
	set_data("just_completed", !from_check)

func _on_dialogue_closed():
	reset_data()
