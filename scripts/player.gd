extends CharacterBody2D

@export var speed = 400

var destination: Vector2
var has_destination: bool

const MIN_MOVE_RANGE = 4

func get_input():
	if Input.is_action_just_pressed("click") and get_global_mouse_position().y < 960:
		var possible = get_global_mouse_position() + Vector2(0, -96)
		if position.distance_to(possible) >= MIN_MOVE_RANGE:
			destination = possible
			has_destination = true
		
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

	if get_slide_collision_count() > 0 or position.distance_to(destination) <= MIN_MOVE_RANGE:
		velocity = Vector2.ZERO
		has_destination = false

	if (velocity != Vector2.ZERO):
		$AnimatedSprite2D.play("run")
	else:
		$AnimatedSprite2D.play("idle")
