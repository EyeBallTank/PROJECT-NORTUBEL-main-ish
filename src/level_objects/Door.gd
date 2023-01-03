extends Area2D

var player = false

func _ready():
	pass



func _on_Door_body_entered(body):
	player = body
	SceneManager.change_scene("level_transition_effect", "res://src/levels/LevelTemplate2.tscn")



func _on_Door_body_exited(body):
	pass # Replace with function body.
