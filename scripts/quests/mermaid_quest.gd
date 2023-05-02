extends QuestData
class_name MermaidQuest

func _get_text() -> String:
	if get_data("handed_over_letter"):
		return "Ah... interesting. I know who she is, but my heart is set on another. Please deliver this necklace to the baker."

	return "You know, you shouldn't stare. Have you never seen a mermaid before?"

func _get_options() -> Array[Dictionary]:
	return [
		{
			"action_id": "give_letter",
			"enabled": Global.inventory_data.has_item("Guard's Letter"),
			"text": "[Hand over letter]"
		}
	]

func _on_option_chosen(action_id: String):
	match action_id:
		"give_letter":
			Global.inventory_data.remove_item("Guard's Letter")
			Global.inventory_data.try_add_item("Shell Necklace")
			set_data("handed_over_letter", true)
			complete_quest()

func _on_dialogue_closed():
	reset_data()
