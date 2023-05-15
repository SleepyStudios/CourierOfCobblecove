extends CharacterBody2D
class_name Player

signal on_destination_set(destination: Vector2)

@export var speed = 300

var in_dialogue_with_npc: NPC
var tmr_dialogue_last_opened: float

@onready var footstep_player = $FootstepPlayer
var step_left = preload("res://sounds/step_left.wav")
var step_right = preload("res://sounds/step_right.wav")
var steps: int
var tmr_footstep: float

@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D

var position_last_frame: Vector2

func _ready():
	Global.register_player(self)
	
func set_in_dialogue_with_npc(npc: NPC):
	if tmr_dialogue_last_opened >= 1:
		in_dialogue_with_npc = npc
		in_dialogue_with_npc.show_dialogue()
		tmr_dialogue_last_opened = 0

func hide_dialogue():
	in_dialogue_with_npc.hide_dialogue()
	in_dialogue_with_npc = null

func _unhandled_input(event):
	if event.is_action_pressed("click"):
		var destination = get_global_mouse_position()
		navigation_agent.target_position = destination
		on_destination_set.emit(destination)

func play_footstep(delta):
	tmr_footstep += delta
	if tmr_footstep >= 0.3:
		footstep_player.pitch_scale = RandomNumberGenerator.new().randf_range(1, 1.1)
		footstep_player.stream = step_left if steps % 2 == 0 else step_right
		footstep_player.play()
		steps += 1
		tmr_footstep = 0

func _physics_process(delta):
	tmr_dialogue_last_opened += delta
	position_last_frame = position

	if navigation_agent.is_navigation_finished():
		$AnimatedSprite2D.play("idle")
		return

	velocity = position.direction_to(navigation_agent.get_next_path_position()).normalized() * speed
	if move_and_slide():
		position = position_last_frame
		navigation_agent.target_position = position

	if get_last_slide_collision():
		var collider = get_last_slide_collision().get_collider()
		if collider.get_groups().has("NPCs") and not in_dialogue_with_npc:
			set_in_dialogue_with_npc(collider)
	elif in_dialogue_with_npc:
		hide_dialogue()

	if (velocity.x < 0):
		$AnimatedSprite2D.flip_h = true;
	elif (velocity.x > 0):
		$AnimatedSprite2D.flip_h = false;

	if position.distance_to(navigation_agent.get_next_path_position()) >= 4:
		$AnimatedSprite2D.play("run")
		play_footstep(delta)	

func set_post_teleport_data(data: Dictionary):
	if data:
		$AnimatedSprite2D.flip_h = data.flip
		var anchor: Node2D = get_node("../" + data.anchor + "Anchor")
		
		match data.anchor:
			"Top", "Bottom":
				position.x = data.xPos
				position.y = anchor.position.y
			"Left", "Right":
				position.x = anchor.position.x
				position.y = data.yPos

func get_teleport_data() -> Dictionary:
	return {
		"flip": $AnimatedSprite2D.flip_h,
		"xPos": position.x,
		"yPos": position.y
	}
