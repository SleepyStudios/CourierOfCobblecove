extends Node

@export var current_zone: String
@export var picked_up: Dictionary = {}
@export var dropped: Dictionary = {}

func _ready():
	Global.dropped_item_registered.connect(_on_dropped_item_registered)
	Global.dropped_item_unregistered.connect(_on_dropped_item_unregistered)
	$"../SceneTransition".on_scene_changed.connect(_on_scene_changed)

func _on_dropped_item_registered(dropped_item: DroppedItem):
	if picked_up[current_zone].has(dropped_item.drop_id):
		dropped_item.queue_free()
	elif not dropped_item.comes_with_scene:
		dropped[current_zone].push_back(dropped_item)

func _on_dropped_item_unregistered(dropped_item: DroppedItem):
	picked_up[current_zone].push_back(dropped_item.drop_id)

	for i in len(dropped[current_zone]):
		if dropped[current_zone][i].drop_id == dropped_item.drop_id:
			dropped[current_zone].remove_at(i)
			break

func _on_scene_changed(new_scene_path: String):
	var old_zone = current_zone
	
	var regex = RegEx.new()
	regex.compile("(?<=zones\\/)[a-z]\\d")
	current_zone = regex.search(new_scene_path).get_string()
	
	if not picked_up.has(current_zone):
		picked_up[current_zone] = []
		
	if not dropped.has(current_zone):
		dropped[current_zone] = []
	
	if old_zone:	
		toggle_dropped_items(old_zone)
	
func toggle_dropped_items(old_zone: String):
	for dropped_item in dropped[old_zone]:
		dropped_item.hide()

	for dropped_item in dropped[current_zone]:
		dropped_item.show()
