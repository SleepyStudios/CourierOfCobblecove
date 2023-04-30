extends Resource
class_name DialogueData

@export_multiline var default_text: String
@export_multiline var post_success_text: String

@export_multiline var action_options: Array[String]
@export var action_requirements: Array[ItemData]
@export_multiline var action_success_texts: Array[String]
@export_multiline var action_callbacks: Array[String]
