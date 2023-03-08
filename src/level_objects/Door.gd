extends Area2D

#Should probably make it so endlevel doors and such require both player and companion to end level

func _ready():
	pass 


func _on_Door_body_entered(body):
	if body.is_in_group("protagonists"):
		SceneManager.change_scene("level_transition_effect", "res://src/levels/LevelTemplate2.tscn")
