extends StaticBody2D
class_name NPC

@export var dialogue_data: DialogueData
const DialogueBox = preload("res://scenes/dialogue_box.tscn")

var dialogue_box: DialogueBox

func _ready():
	$Animation.play("idle")
	if dialogue_data:
		dialogue_box = DialogueBox.instantiate()
		dialogue_box.dialogue_data = dialogue_data
		dialogue_box.npc_name = name
		dialogue_box.hide()
		$CanvasLayer.add_child(dialogue_box)

func show_dialogue():
	if dialogue_data:
		$CanvasLayer/DialogueBox.visible = true
		dialogue_box.show_dialogue()

func hide_dialogue():
	$CanvasLayer/DialogueBox.visible = false
