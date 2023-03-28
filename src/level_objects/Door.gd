extends Area2D

#Should probably make it so endlevel doors and such require both player and companion to end level

export var new_scene = "res://src/levels/LevelTemplate2.tscn"

func _ready():
	pass 


func _on_Door_body_entered(body):
	if body.is_in_group("protagonists"):
		SceneManager.change_scene("level_transition_effect", new_scene)
