extends QuestData
class_name MermaidQuest

func _get_text() -> String:
	if get_data("just_completed"):
		return "Yes! This is it! Thank you stranger. While you've been gone I wrote my own letter, please deliver it to my admirer."
	
	if get_data("dull_shell_given"):
		return "This isn't it! Clearly! Only a fool would think this shell is enchanted."
	
	if get_data("just_started"):
		return "Oh - she's ever so sweet. Alas, she doesn't know me for who I really am. Using an Enchanted Shell I can disguise myself - but my shell has vanished. Can you find it for me?"
	
	if is_quest_started():
		return "Have you found my shell?"
	
	if is_quest_completed():
		return "I'm so happy to have my shell back, it's ever so hard to walk on land without legs."

	return "You know, you shouldn't stare. Have you never seen a mermaid before?"

func _get_options() -> Array[Dictionary]:
	return [
		{
			"action_id": "give_letter",
			"enabled": Global.inventory_data.has_item("Guard's Letter"),
			"text": "[Hand over letter]"
		},
		{
			"action_id": "give_dull_shell",
			"enabled": Global.inventory_data.has_item("Dull Shell") and is_quest_started() and not get_data("dull_shell_given"),
			"text": "[Hand over Shell]"
		},
		{
			"action_id": "give_shiny_shell",
			"enabled": Global.inventory_data.has_item("Shiny Shell"),
			"text": "[Hand over Shiny Shell]"
		}
	]

func _on_option_chosen(action_id: String):
	match action_id:
		"give_letter":
			Global.inventory_data.remove_item("Guard's Letter")
			start_quest()
		"give_dull_shell":
			set_data("dull_shell_given", true)
		"give_shiny_shell":
			Global.inventory_data.remove_item("Shiny Shell")
			Global.inventory_data.try_add_item("Mermaid's Letter")
			complete_quest()

func _handle_quest_started():
	set_data("just_started", true)

func _handle_quest_completed(from_check: bool):
	set_data("just_completed", !from_check)

func _on_dialogue_closed():
	reset_data()
