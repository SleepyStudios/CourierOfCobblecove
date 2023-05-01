extends QuestData
class_name GoblinQuest

func _get_text() -> String:
	if get_data("just_completed"):
		return "Goblin surprised! You bring friend back. Magic broken? How you do that? Maybe you know magic too? Take best stick. Stick strong, good for hitting"
	
	if is_quest_completed():
		return "Stick make you strong!"
	
	return "Beware wizard's magic! Friend no longer friend. Moo! Better to stay far away, yes?"
	
func _get_options() -> Array[Dictionary]:
	return []

func _on_option_chosen(action_id: String):
	pass

func _handle_quest_completed(from_check: bool):
	set_data("just_completed", !from_check)

func _on_dialogue_opened():
	if not is_quest_completed():
		Global.inventory_data.try_add_item('"Best" Stick')
		complete_quest()

func _on_dialogue_closed():
	reset_data()
