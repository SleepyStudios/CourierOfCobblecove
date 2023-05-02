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
		},
		{
			"action_id": "give_potion",
			"enabled": Global.inventory_data.has_item("Mysterious Potion"),
			"text": "[Give Buttercup a potion]"
		}
	]
	
func _on_option_chosen(action_id: String):
	match action_id:
		"give_lead":
			Global.inventory_data.remove_item("Carrot")
			complete_quest()
		"give_potion":
			Global.inventory_data.remove_item("Mysterious Potion")
			Global.quest_manager.start_quest("Goblin")
			set_data("potion_given", true)
			npc.animation.play("goblin")
			npc.animator_play_anim("shrink")
			npc.hide_dialogue()

func _handle_quest_completed(from_check: bool):
	if Global.map_manager.current_zone == "b4":
		if from_check:
			npc.queue_free()
		else:
			npc.animation.play("walking")			
			npc.follow_path(300.0, 0.5)
			npc.hide_dialogue()
	else:
		if from_check and get_data("potion_given"):
			npc.queue_free()
		else:			
			npc.animation.flip_h = true

func _handle_quest_not_completed():
	if Global.map_manager.current_zone == "e3" or get_data("potion_given"):
		npc.queue_free()
