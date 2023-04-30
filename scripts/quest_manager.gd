extends Node

@export var completed_quests: Array[String] = []
@export var completed_quest_action_indexes: Array[int] = []

func is_quest_completed(quest_name: String) -> bool:
	return completed_quests.has(quest_name)

func complete_quest(quest_name: String, action_index: int):
	completed_quests.push_back(quest_name)
	completed_quest_action_indexes.push_back(action_index)

func get_completed_quest_action_index(quest_name: String) -> int:
	return completed_quest_action_indexes[completed_quests.find(quest_name)]
