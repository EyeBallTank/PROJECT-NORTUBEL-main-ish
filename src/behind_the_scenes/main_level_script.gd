extends Node
class_name main_level_script
# In case levels need a script
const PlayerScene = preload("res://src/play_actors/PlayerCopy.tscn")
const CompScene = preload("res://src/play_actors/CompanionFourth.tscn")

var player_spawn_location = Vector2.ZERO
var companion_spawn_location = Vector2.ZERO

onready var mainplayer: = $Player
onready var maincomp: = $Companion

func _ready():
	player_spawn_location = mainplayer.global_position
	companion_spawn_location = maincomp.global_position
	Signals.connect("player_died", self, "_on_someone_died")
	Signals.connect("hit_checkpoint", self, "_on_hit_checkpoint")
	Signals.connect("companion_died", self, "_on_someone_died")
#	Playerlocation = player.global_position
#	Complocation = companion.global_position
#	var bigsibling = player.instance()
##	var bigsiblinghealth = playerhealth.instance()
#	var littlesibling = companion.instance()
##	var littlesiblinghealth = companionhealth.instance()
#	var porta = door.instance()

func _on_someone_died():
	var player = PlayerScene.instance()
	player.position = player_spawn_location
	add_child(player)
	var companion = CompScene.instance()
	companion.position = companion_spawn_location
	add_child(companion)

func _on_hit_checkpoint(checkpoint_position):
	player_spawn_location = checkpoint_position
	companion_spawn_location = checkpoint_position
