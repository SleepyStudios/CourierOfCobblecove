extends StaticBody2D
class_name NPC

@export var quest_data: QuestData
const DialogueBox = preload("res://scenes/dialogue_box.tscn")

@onready var animation = $Animation

var dialogue_box: DialogueBox
var speed: float
var disable_collision_at_ratio: float
var path_follow: PathFollow2D

func _ready():
	animation.play("idle")
	if quest_data:
		dialogue_box = DialogueBox.instantiate()
		dialogue_box.quest_data = quest_data
		dialogue_box.quest_data.npc = self
		dialogue_box.hide()
		$CanvasLayer.add_child(dialogue_box)

func show_dialogue():
	if quest_data and not path_follow:
		dialogue_box.show_dialogue()

func hide_dialogue():
	if quest_data:
		dialogue_box.hide_dialogue()
		
func follow_path(speed: float, disable_collision_at_ratio = -1):
	self.speed = speed
	self.disable_collision_at_ratio = disable_collision_at_ratio
	path_follow = get_parent()

func _physics_process(delta):
	if path_follow:
		path_follow.set_progress(path_follow.get_progress() + speed * delta)
		if disable_collision_at_ratio > 0 and path_follow.progress_ratio >= disable_collision_at_ratio:
			var collision_shape = get_node_or_null("CollisionShape")
			if collision_shape:
				collision_shape.queue_free()

func animator_play_anim(name: String):
	$AnimationPlayer.play("shrink")
