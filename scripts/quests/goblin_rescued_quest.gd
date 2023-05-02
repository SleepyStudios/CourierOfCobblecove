extends QuestData
class_name GoblinRescuedQuest

func _get_text() -> String:
	return ""
	
func _get_options() -> Array[Dictionary]:
	return []

func _on_option_chosen(action_id: String):
	pass

func _handle_quest_not_completed():
	if not Global.quest_manager.is_quest_started("Goblin"):
		npc.queue_free()
