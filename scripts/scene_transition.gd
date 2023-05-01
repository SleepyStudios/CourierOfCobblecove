extends CanvasLayer

signal on_scene_changed(new_scene_path: String)

func load_initial_scene():
	$AnimationPlayer.play_backwards("black")
	on_scene_changed.emit(get_tree().current_scene.scene_file_path)

func change_scene(target: String, anim: = "black"):
	$AnimationPlayer.play(anim)
	await $AnimationPlayer.animation_finished

	get_tree().change_scene_to_file(target)
	$AnimationPlayer.play_backwards(anim)
	
	if not target.contains("ending"):
		on_scene_changed.emit(target)
		
