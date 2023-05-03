extends Node
class_name main_level_script
# In case levels need a script
#const PlayerScene = preload("res://src/play_actors/PlayerCopy.tscn")
#const CompScene = preload("res://src/play_actors/CompanionFourth.tscn")

#var player_spawn_location = Vector2.ZERO
#var companion_spawn_location = Vector2.ZERO

#var lives = Signals.lives

#onready var mainplayer: = $Player
#onready var maincomp: = $Companion
#
#func _ready():
#	player_spawn_location = mainplayer.global_position
#	companion_spawn_location = maincomp.global_position
#	Signals.connect("player_died", self, "_on_someone_died")
#	Signals.connect("hit_checkpoint", self, "_on_hit_checkpoint")
#	Signals.connect("companion_died", self, "_on_someone_died")
#
#func _on_someone_died():
##	yield(get_tree().create_timer(0.5), "timeout")
#	var player = PlayerScene.instance()
#	player.position = player_spawn_location
#	add_child(player)
#	player.set_name("Player")
#	var companion = CompScene.instance()
#	companion.position = companion_spawn_location
#	add_child(companion)
#	companion.set_name("Companion")
#
#func _on_hit_checkpoint(checkpoint_position):
#	player_spawn_location = checkpoint_position
#	companion_spawn_location = checkpoint_position
