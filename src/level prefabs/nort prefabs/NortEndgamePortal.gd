extends Area2D


func _ready():
	pass




func _on_NortEndgamePortal_body_entered(body):
	if body.name == "Player":
		SceneManager.change_scene("level_transition_effect", "res://screens/cutscenes/cutscene 32 nortpartnine home/cutscene 32 nortpartnine home.tscn")
	if body.name == "Companion":
		SceneManager.change_scene("level_transition_effect", "res://screens/cutscenes/cutscene 32 nortpartnine home/cutscene 32 nortpartnine home.tscn")
	if body.name == "Rival":
		SceneManager.change_scene("level_transition_effect", "res://screens/GameOver.tscn")
	if body.name == "RivalCompanion":
		SceneManager.change_scene("level_transition_effect", "res://screens/GameOver.tscn")
