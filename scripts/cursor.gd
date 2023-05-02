extends AnimatedSprite2D

const CursorAnim = preload("res://scenes/cursor_anim.tscn")

func _ready():
	set_frame_and_progress(1, 1)
	if OS.has_feature("web"):
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)		
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED_HIDDEN)

func _unhandled_input(event):
	if event.is_action_pressed("click"):
		play("default")
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()

func connect_player(player: Player):
	player.on_destination_set.connect(_on_destination_set)

func _process(delta):
	position = get_global_mouse_position()

func _on_destination_set(destination: Vector2):
	var cursor_anim = CursorAnim.instantiate()
	cursor_anim.position = get_global_mouse_position()
	Global.add_child(cursor_anim)

func start_dragging():
	set_frame_and_progress(0, 0)

func stop_dragging():
	set_frame_and_progress(1, 1)

func play_anim():
	set_frame_and_progress(1, 1)
	play("default")
