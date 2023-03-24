extends Node
class_name main_level_script

# In case levels need a script

onready var player = preload("res://src/play_actors/PlayerCopy.tscn")
#onready var playerhealth = preload("res://src/menusandui/healthbarPlayer.tscn")
onready var companion = preload("res://src/play_actors/CompanionFourth.tscn")
#onready var companionhealth = preload("res://src/menusandui/healthbarCompanion.tscn")
onready var door = preload("res://src/level_objects/Door.tscn")


#func _ready():
#	Playerlocation = player.global_position
#	Complocation = companion.global_position
#	var bigsibling = player.instance()
##	var bigsiblinghealth = playerhealth.instance()
#	var littlesibling = companion.instance()
##	var littlesiblinghealth = companionhealth.instance()
#	var porta = door.instance()
