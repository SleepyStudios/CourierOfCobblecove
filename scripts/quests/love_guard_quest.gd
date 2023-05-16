extends QuestData
class_name LoveGuardQuest

func _get_text() -> String:
	if get_data("just_started"):
		return "Here, take this to the cove. You'll know who this is for when you see her."
	
	if get_data("just_completed"):
		if get_data("handed_in_box"):
			return "Are these for me? Are they from who I think they're from? I knew it! Thank you messenger, I'll pass on your delivery."
		else:
			return "Are these for me? Are they from who I think they're from? I knew it!"

	if is_quest_started():
		return "Have you delivered my letter yet?"
	
	if is_quest_completed():
		return "I shouldn't be speaking to you..."
	
	if not Global.inventory_data.has_item("Box"):
		return "You seem to be trespassing, messenger. Unless you have something to deliver, be on your way."

	return "Ah, a delivery. I can pass this on... for a favour. Will you deliver a letter for me?"

func _get_options() -> Array[Dictionary]:
	return [
		{
			"action_id": "give_flowers",
			"enabled": Global.inventory_data.has_item("Flower"),
			"text": "[Hand over flowers]"
		},
		{
			"action_id": "take_letter",
			"enabled": not is_quest_completed() and not is_quest_started(),
			"text": "[Take the letter]"
		}
	]

func _on_option_chosen(action_id: String):
	match action_id:
		"give_flowers":
			Global.inventory_data.remove_item("Flower")
			complete_quest()
			if Global.inventory_data.has_item("Box"):
				set_data("handed_in_box", true)
				Global.inventory_data.remove_item("Box")
				complete_quest()
		"take_letter":
			Global.inventory_data.try_add_item("Guard's Letter")
			start_quest()

func _handle_quest_completed(from_check: bool):
	set_data("just_completed", !from_check)

func _handle_quest_started():
	set_data("just_started", true)

func _on_dialogue_closed():
	reset_data()
