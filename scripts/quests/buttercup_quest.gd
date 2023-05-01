extends QuestData
class_name ButtercupQuest

func _get_text() -> String:
	return "Moooooo"
	
func _get_options() -> Array[Dictionary]:
	return [
		{
			"action_id": "give_lead",
			"enabled": Global.inventory_data.has_item("Carrot"),
			"text": "[Give Buttercup the carrot]"
		}
	]
	
func _on_option_chosen(action_id: String):
	match action_id:
		"give_lead":
			set_data("lead_given", true)
			Global.inventory_data.remove_item("Carrot")
			complete_quest()

func _handle_quest_completed(from_check: bool):
	if Global.map_manager.current_zone == "b4":
		if from_check:
			npc.queue_free()
		else:
			npc.follow_path(300.0)
			npc.hide_dialogue()
			npc.quest_data = null
	else:
		npc.animation.flip_h = true

func _handle_quest_not_completed():
	if Global.map_manager.current_zone == "e3":
		npc.queue_free()
