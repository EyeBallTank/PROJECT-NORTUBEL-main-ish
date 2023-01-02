extends Node


#Copying code from Israel Ruiz, it may not work but...

onready var animation = $CanvasLayer/AnimationPlayer
var scene : String

func change_scene(anim, new_scene, anim2):
	animation.play(anim)
	yield(get_tree().create_timer(1.0), "timeout")
	scene = new_scene
	yield(get_tree().create_timer(1.0), "timeout")
	animation.play_backwards(anim2)

func _new_scene():
		get_tree().change_scene(scene)
