extends CharacterBody2D

@export var speed = 300

func get_input():
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = input_direction * speed

func _physics_process(delta):
	get_input()

	if (Input.is_action_pressed("move_left")):
		$AnimatedSprite2D.flip_h = true;
	if (Input.is_action_pressed("move_right")):
		$AnimatedSprite2D.flip_h = false;		
		
	if (velocity != Vector2.ZERO):
		$AnimatedSprite2D.play("run")
	else:
		$AnimatedSprite2D.play("idle")
	
	move_and_slide()
