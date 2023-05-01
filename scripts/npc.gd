extends StaticBody2D
class_name NPC

@export var quest_data: QuestData
const DialogueBox = preload("res://scenes/dialogue_box.tscn")

@onready var animation = $Animation

var dialogue_box: DialogueBox

func _ready():
	$Animation.play("idle")
	if quest_data:
		dialogue_box = DialogueBox.instantiate()
		dialogue_box.quest_data = quest_data
		dialogue_box.quest_data.npc = self
		dialogue_box.hide()
		$CanvasLayer.add_child(dialogue_box)

func show_dialogue():
	if quest_data:
		dialogue_box.show_dialogue()

func hide_dialogue():
	dialogue_box.hide_dialogue()
	
