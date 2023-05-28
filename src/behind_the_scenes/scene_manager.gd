extends Node

#onready var save_file = SaveFile.g_data
#Copying code from Israel Ruiz, it may not work but...

onready var animation = $CanvasLayer/AnimationPlayer
var scene : String

#var loaded_scene = save_file

func change_scene(anim, new_scene):
	scene = new_scene
	animation.play(anim)

func _new_scene():
	get_tree().change_scene(scene)

func pause_the_game():
	get_tree().paused = true

func unpause_the_game():
	get_tree().paused = false

#func _load_scene():
#	get_tree().change_scene(loaded_scene)
#
#func loading_scene(anim, loaded_scene):
#	scene = loaded_scene
#	animation.play("level_transition_effect2")

#func load_scene():
#	change_scene("level_transition_effect", loaded_scene)
