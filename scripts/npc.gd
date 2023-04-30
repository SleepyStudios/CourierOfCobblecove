extends StaticBody2D
class_name NPC

@export var dialogue_data: DialogueData

func _ready():
	$Animation.play("idle")

func show_dialogue():
	$CanvasLayer/DialogueBox.visible = true
	$CanvasLayer/DialogueBox/MarginContainer/Text.text = dialogue_data.default_text

func hide_dialogue():
	$CanvasLayer/DialogueBox.visible = false
		
