extends QuestData
class_name BearQuest

func _get_text() -> String:
	return "Zzzzz... zzz... zzzzzzzz... zzzzz"
	
func _get_options() -> Array[Dictionary]:
	return [
		{
			"action_id": "complete",
			"enabled": Global.inventory_data.has_item("Honey"),
			"text": "[Wake the bear with honey]"
		}
	]

func _on_option_chosen(action_id: String):
	match action_id:
		"complete":
			Global.inventory_data.remove_item("Honey")
			complete_quest()

func _handle_quest_completed(from_check: bool):
	if from_check:
		npc.queue_free()
	else:
		npc.animation.play("running")
		npc.follow_path(200.0)	
		npc.hide_dialogue()
