extends Resource
class_name QuestData

@export var npc: NPC
var just_started: bool

func is_quest_completed() -> bool:
	return Global.quest_manager.is_quest_completed(_get_quest_name())
	
func is_quest_started() -> bool:
	return Global.quest_manager.is_quest_started(_get_quest_name())

func start_quest():
	just_started = true	
	Global.quest_manager.start_quest(_get_quest_name())
	
func complete_quest():
	Global.quest_manager.complete_quest(_get_quest_name())

func check_is_completed():
	if is_quest_completed():
		_handle_quest_completed(true)

func set_data(key: String, val: Variant):
	Global.quest_manager.set_data_for_quest(_get_quest_name(), key, val)

func get_data(key: String, val: Variant) -> Variant:
	return Global.quest_manager.get_data_for_quest(_get_quest_name(), key, val)

func reset_data():
	Global.quest_manager.reset_data_for_quest(_get_quest_name())

func _get_quest_name() -> String:
	return npc.name

func _get_text() -> String:
	return ""
	
func _get_options() -> Array[Dictionary]:
	return []

func _handle_quest_completed(from_check: bool):
	pass
	
func _on_option_chosen(action_id: String):
	pass
	
func _on_dialogue_closed():
	just_started = false

func _action_play_anim(anim_name: String):
	npc.animation.play(anim_name)
