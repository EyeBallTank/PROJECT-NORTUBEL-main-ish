extends Node


#Copying code from Israel Ruiz, it may not work but...

onready var animation = $CanvasLayer/AnimationPlayer
var scene : String

func change_scene(anim, new_scene):
	scene = new_scene
	animation.play(anim)
#	transfer_data_between_scenes(scene, new_scene)

func _new_scene():
	get_tree().change_scene(scene)

func pause_the_game():
	get_tree().paused = true

func unpause_the_game():
	get_tree().paused = false

#func transfer_data_between_scenes(old_level, new_level):
#	Signals.lives = Signals.lives
