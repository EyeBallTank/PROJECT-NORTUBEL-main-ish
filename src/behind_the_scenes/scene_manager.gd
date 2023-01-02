extends Node


#Copying code from Israel Ruiz, it may not work but...

onready var animation = $CanvasLayer/AnimationPlayer
var scene : String

func change_scene(new_scene, anim):
	scene = new_scene
	animation.play(anim)

func _new_scene():
		get_tree().change_scene(scene)
