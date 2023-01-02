extends Control



func _on_StartButton_pressed():
	SceneManager.change_scene("level_transition_effect", "res://src/levels/LevelTemplate.tscn", "level_transition_effect")


func _on_QuitButton_pressed():
	get_tree().quit()
