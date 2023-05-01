extends QuestData
class_name OldManQuest

func _get_text() -> String:
	return get_data("text")

func _get_options() -> Array[Dictionary]:
	return [
		{
			"action_id": "0",
			"enabled": get_data("step") == 0,
			"text": "I gave it an offering"
		},
		{
			"action_id": "1",
			"enabled": get_data("step") == 1,
			"text": "A small ruby gem"
		},
		{
			"action_id": "2",
			"enabled": get_data("step") == 2,
			"text": "Where did you find it?"
		},
		{
			"action_id": "3",
			"enabled": get_data("step") == 3,
			"text": "I'd like that"
		}
	]

func _on_option_chosen(action_id: String):
	match action_id:
		"0":
			set_data("step", 1)
			set_data("text", "An offering? What sort of offering?")
		"1":
			set_data("step", 2)
			set_data("text", "A red gem you say... I suppose it makes sense. I knew I'd finally lose it one day")
		"2":
			set_data("step", 3)
			set_data("text", "You know I rarely have visitors up here, so far away. Would you like some tea? It's a long story...")
		"3":
			npc.hide_dialogue()
			Global.ui.queue_free()
			Global.scene_transition.change_scene("res://scenes/ending.tscn", "white")

func _on_dialogue_opened():
	set_data("step", 0)
	set_data("text", "You there! How did you get here? There was a demon... guarding the river!")
