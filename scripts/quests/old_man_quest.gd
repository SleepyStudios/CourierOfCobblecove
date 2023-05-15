extends QuestData
class_name OldManQuest

func _get_text() -> String:
	return get_data("text")

func _get_options() -> Array[Dictionary]:
	return [
		{
			"action_id": "0",
			"enabled": get_data("step") == 0 and Global.inventory_data.has_item("Gem"),
			"text": "Are you missing a large gem?"
		},
		{
			"action_id": "1",
			"enabled": get_data("step") == 1,
			"text": "I found it"
		},
		{
			"action_id": "2",
			"enabled": get_data("step") == 2,
			"text": "It sounds like you've got a story to tell"
		},
		{
			"action_id": "3",
			"enabled": get_data("step") == 3,
			"text": "I'd like that"
		},
		{
			"action_id": "4",
			"enabled": get_data("step") == 3,
			"text": "I need to make some deliveries first"
		}
	]

func _on_option_chosen(action_id: String):
	match action_id:
		"0":
			set_data("step", 1)
			set_data("text", "Why, yes, I am. I lost it somewhere at the bottom of the cliffs")
		"1":
			set_data("step", 2)
			set_data("text", "Many thanks indeed! This gem and I are one and the same...")
		"2":
			set_data("step", 3)
			set_data("text", "You know I rarely have visitors up here, so far away. Would you like some tea? It's a long story...")
		"3":
			npc.hide_dialogue()
			Global.ui.queue_free()
			Global.scene_transition.change_scene("res://scenes/ending.tscn", "white")
		"4":
			npc.hide_dialogue()

func _on_dialogue_opened():
	set_data("step", 0)
	set_data("text", "Hello? How can I help you?")

func _on_dialogue_closed():
	reset_data()
