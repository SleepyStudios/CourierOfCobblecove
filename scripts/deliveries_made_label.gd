extends Label

func _ready():
	var count = len(Global.quest_manager.completed_quests)
	text = "You made %s %s" % [count, "delivery" if count == 1 else "deliveries"]
