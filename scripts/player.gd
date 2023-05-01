extends CharacterBody2D
class_name Player

signal on_destination_set(destination: Vector2)

const MIN_MOVE_RANGE = 4

@export var speed = 300

var destination: Vector2
var has_destination: bool
var in_dialogue_with_npc: NPC
var hide_dialogue_this_frame: bool

func _ready():
	Global.register_player(self)

func hide_dialogue():
	hide_dialogue_this_frame = true
	
func exit_dialogue_immediately():
	in_dialogue_with_npc.hide_dialogue()
	in_dialogue_with_npc = null

func _unhandled_input(event):
	if event.is_action_pressed("click") and get_global_mouse_position().y < 900:
		var possible = get_global_mouse_position() + Vector2(0, -96)
		if position.distance_to(possible) >= MIN_MOVE_RANGE:
			destination = possible
			has_destination = true
			
			if in_dialogue_with_npc:
				exit_dialogue_immediately()

			on_destination_set.emit(destination)

func get_input():
	if hide_dialogue_this_frame:
		exit_dialogue_immediately()
		hide_dialogue_this_frame = false
		return
	
	if not has_destination:
		velocity = Vector2.ZERO
		return

	velocity = (destination - position).normalized() * speed
	
	if (velocity.x < 0):
		$AnimatedSprite2D.flip_h = true;
	else:
		$AnimatedSprite2D.flip_h = false;

func _physics_process(delta):
	get_input()
	
	if move_and_slide() or position.distance_to(destination) <= MIN_MOVE_RANGE:
		has_destination = false
	
	if (has_destination):
		$AnimatedSprite2D.play("run")
	else:
		$AnimatedSprite2D.play("idle")

	if not velocity == Vector2.ZERO and get_slide_collision_count() > 0:
		for i in get_slide_collision_count():
			var collider = get_slide_collision(i).get_collider()
			if collider.get_groups().has("NPCs") and not in_dialogue_with_npc:
				in_dialogue_with_npc = collider
				in_dialogue_with_npc.show_dialogue()

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
