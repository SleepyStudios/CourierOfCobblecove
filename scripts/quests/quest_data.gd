extends Resource
class_name QuestData

@export var npc: NPC

func is_quest_completed() -> bool:
	return Global.quest_manager.is_quest_completed(_get_quest_name())
	
func is_quest_started() -> bool:
	return Global.quest_manager.is_quest_started(_get_quest_name())

func start_quest():
	Global.quest_manager.start_quest(_get_quest_name())
	_handle_quest_started()

func complete_quest():
	Global.quest_manager.complete_quest(_get_quest_name())
	_handle_quest_completed(false)

func check_is_completed():
	if is_quest_completed():
		_handle_quest_completed(true)
	else:
		_handle_quest_not_completed()

func set_data(key: String, val: Variant):
	Global.quest_manager.set_data_for_quest(_get_quest_name(), key, val)

func get_data(key: String) -> Variant:
	return Global.quest_manager.get_data_for_quest(_get_quest_name(), key)

func reset_data():
	Global.quest_manager.reset_data_for_quest(_get_quest_name())

func _get_quest_name() -> String:
	return npc.name

func _get_text() -> String:
	return ""
	
func _get_options() -> Array[Dictionary]:
	return []

func _handle_quest_started():
	pass

func _handle_quest_completed(from_check: bool):
	pass
	
func _handle_quest_not_completed():
	pass
	
func _on_option_chosen(action_id: String):
	pass

func _on_dialogue_opened():
	pass

func _on_dialogue_closed():
	pass

func _action_play_anim(anim_name: String):
	npc.animation.play(anim_name)
