extends Node2D

var inventory_data = preload("res://resources/inventory.tres")

var post_teleport_data: Dictionary
var _player: Player

func _ready():
	$SceneTransition.load_initial_scene()

func go_to_zone(zone: String):
	$SceneTransition.change_scene("res://scenes/zones/%s.tscn" % zone)
	post_teleport_data = _player.get_teleport_data()

func register_player(player: Player):
	_player = player
	player.set_post_teleport_data(post_teleport_data)
