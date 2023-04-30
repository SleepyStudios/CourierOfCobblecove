extends CanvasLayer

func load_initial_scene():
	$AnimationPlayer.play_backwards("dissolve")

func change_scene(target: String):
	$AnimationPlayer.play("dissolve")
	await $AnimationPlayer.animation_finished

	get_tree().change_scene_to_file(target)
	$AnimationPlayer.play_backwards("dissolve")
