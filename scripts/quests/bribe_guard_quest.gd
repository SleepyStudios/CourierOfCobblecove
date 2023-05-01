extends QuestData
class_name BribeGuardQuest

func _get_text() -> String:
	if get_data("just_completed"):
		return "3 measly coins? Hmph. I suppose that's enough to pass on your delivery."
	
	if is_quest_completed():
		return "Don't worry messenger, your delivery was handled with the best care provided by 3 measly coins"
	
	if not Global.inventory_data.has_item("Box"):
		return "A messenger? With nothing to deliver? Be gone, rat!"

	return "A delivery directly for the Lord, you say? Such deliveries should be handled with care. The care that can only be provided in exchange for a small fee."
	
func _get_options() -> Array[Dictionary]:
	if not Global.inventory_data.has_item("Box"):
		return []

	return [
		{
			"action_id": "give_coins",
			"enabled": Global.inventory_data.has_item("Coins"),
			"text": "[Hand over coins]"
		}
	]

func _on_option_chosen(action_id: String):
	match action_id:
		"give_coins":
			Global.inventory_data.remove_item("Coins")
			Global.inventory_data.remove_item("Box")
			complete_quest()

func _handle_quest_completed(from_check: bool):
	set_data("just_completed", !from_check)
	
func _on_dialogue_closed():
	reset_data()
