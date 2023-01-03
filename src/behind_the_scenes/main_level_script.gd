extends Node
class_name main_level_script

# In case levels need a script

onready var player = preload("res://src/play_actors/Player.tscn")
onready var companion = preload("res://src/play_actors/Companion.tscn")
onready var door = preload("res://src/level_objects/Door.tscn")

func _ready():
	var bigsibling = player.instance()
	var littlesibling = companion.instance()
	var porta = door.instance()
