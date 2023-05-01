extends Label

func _ready():
	$"../../SceneTransition".on_scene_changed.connect(_on_scene_changed)

func _on_scene_changed(new_scene_path: String):
	var regex = RegEx.new()
	regex.compile("(?<=zones\\/)[a-z]\\d")
	var current_zone = regex.search(new_scene_path).get_string()
	
	var zone_name = "Name not set :("
	match current_zone:
		"a2": zone_name = "THE WIZARD'S TOWER"
		"a3": zone_name = "THE WIZARD'S TOWER"
		"b3": zone_name = "THE DARK FOREST"
		"b4": zone_name = "THE CLEARING"
		"c2": zone_name = "THE VILLAGE"
		"c3": zone_name = "THE DARK FOREST"
		"c4": zone_name = "THE FOREST"
		"c5": zone_name = "THE MOUNTAIN"
		"c6": zone_name = "THE COVE"
		"d2": zone_name = "THE CROSSING"
		"d2_restored": zone_name = "THE CROSSING"
		"d3": zone_name = "NORTH CROSSROADS"
		"d4": zone_name = "SOUTH CROSSROADS"
		"d5": zone_name = "THE BOUNDARY"
		"d6": zone_name = "THE COVE"
		"e2": zone_name = "OLD MAN'S HUT"
		"e3": zone_name = "CLARKE'S FARM"
		"e4": zone_name = "THE CASTLE APPROACH"
		"e5": zone_name = "THE SNAKEPIT"
		"f4": zone_name = "THE CASTLE GATE"
	
	var deliveries = len(Global.quest_manager.completed_quests)
	var word = "DELIVERY" if deliveries == 1 else "DELIVERIES"
	text = "%s\n%s %s MADE" % [zone_name, deliveries, word]
