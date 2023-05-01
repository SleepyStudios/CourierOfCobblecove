extends Node

@export var completed_quests: Array[String] = []
@export var started_quests: Array[String] = []
@export var global_quest_data: Dictionary = {}

func is_quest_completed(quest_name: String) -> bool:
	return completed_quests.has(quest_name)
	
func is_quest_started(quest_name: String) -> bool:
	return started_quests.has(quest_name)

func start_quest(quest_name: String):
	started_quests.push_back(quest_name)

func complete_quest(quest_name: String):
	completed_quests.push_back(quest_name)
	started_quests.erase(quest_name)

	# hacky way to update label
	$"../UI/ZoneNameProgressLabel"._on_scene_changed(get_tree().current_scene.scene_file_path)

func safety_check_data(quest_name: String):
	if not global_quest_data.has(quest_name):
		global_quest_data[quest_name] = {}

func set_data_for_quest(quest_name: String, key: String, val: Variant):
	safety_check_data(quest_name)
	global_quest_data[quest_name][key] = val

func get_data_for_quest(quest_name: String, key: String, val: Variant) -> Variant:
	safety_check_data(quest_name)	
	return (global_quest_data[quest_name] as Dictionary).get(key)
