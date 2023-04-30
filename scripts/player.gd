extends CharacterBody2D
class_name Player

const CursorAnim = preload("res://scenes/cursor_anim.tscn")

const MIN_MOVE_RANGE = 4

@export var speed = 300

var destination: Vector2
var has_destination: bool
var in_dialogue_with_npc: NPC

func _ready():
	Global.register_player(self)

func get_input():
	if Input.is_action_just_pressed("click") and get_global_mouse_position().y < 900:
		var possible = get_global_mouse_position() + Vector2(0, -96)
		if position.distance_to(possible) >= MIN_MOVE_RANGE:
			destination = possible
			has_destination = true

			var cursor_anim = CursorAnim.instantiate()
			cursor_anim.position = get_global_mouse_position()
			get_tree().get_root().add_child(cursor_anim)
			
			if in_dialogue_with_npc:
				in_dialogue_with_npc.hide_dialogue()
				in_dialogue_with_npc = null
		
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
	
	move_and_slide()

	var collision_count = get_slide_collision_count()
	if collision_count > 0 or position.distance_to(destination) <= MIN_MOVE_RANGE:
		has_destination = false

	if (has_destination):
		$AnimatedSprite2D.play("run")
	else:
		$AnimatedSprite2D.play("idle")

	if collision_count > 0:
		for i in collision_count:
			var collider = get_slide_collision(i).get_collider()
			if collider.get_groups().has("NPCs"):
				in_dialogue_with_npc = collider
				in_dialogue_with_npc.show_dialogue()

func set_post_teleport_data(data: Dictionary):
	if data:
		$AnimatedSprite2D.flip_h = data.flip
		position.y = data.yPos

func get_teleport_data() -> Dictionary:
	return {
		"flip": $AnimatedSprite2D.flip_h,
		"yPos": position.y
	}
