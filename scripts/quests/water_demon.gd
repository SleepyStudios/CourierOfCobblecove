extends QuestData
class_name WaterDemon

func _get_text() -> String:
	if is_quest_completed():
		return "AN EXCELLENT GIFT. A STOLEN ARTIFACT FROM THE ELEMENTS. YOUR LANDS WILL BE RESTORED"

	return "YOU THERE! MORTAL! YOUR VILLAGE HAS BEFOULED MY WATERS. I SEEK AN OFFERING IN EXCHANGE FOR RESTORING YOUR PASSAGE"
	
func _get_options() -> Array[Dictionary]:
	return [
		{
			"action_id": "give_gem",
			"enabled": Global.inventory_data.has_item("Gem"),
			"text": "I have this gem"
		},
		{
			"action_id": "stand_back",
			"enabled": is_quest_completed(),
			"text": "[Stand back]"
		}
	]

func _on_option_chosen(action_id: String):
	match action_id:
		"give_gem":
			Global.inventory_data.remove_item("Gem")
			complete_quest()
		"stand_back":
			npc.hide_dialogue()
			Global.go_to_zone("d1", "Left", "white")
