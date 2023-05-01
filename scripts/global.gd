extends Node2D

signal dropped_item_registered(dropped_item: DroppedItem)
signal dropped_item_unregistered(dropped_item: DroppedItem)

var inventory_data = preload("res://resources/inventory.tres")
@onready var quest_manager = $QuestManager
@onready var cursor = $CanvasLayer/Cursor
@onready var scene_transition = $SceneTransition

var post_teleport_data: Dictionary
var player: Player

func _ready():
	scene_transition.load_initial_scene()

func go_to_zone(zone: String, anchor: String):
	scene_transition.change_scene("res://scenes/zones/%s.tscn" % zone)
	post_teleport_data = player.get_teleport_data()
	post_teleport_data["anchor"] = anchor

func register_player(player: Player):
	self.player = player
	player.set_post_teleport_data(post_teleport_data)
	cursor.connect_player(player)

func register_dropped_item(dropped_item: DroppedItem):
	dropped_item_registered.emit(dropped_item)
	
func unregister_dropped_item(dropped_item: DroppedItem):
	dropped_item_unregistered.emit(dropped_item)
