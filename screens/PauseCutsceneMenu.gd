extends Control

#A pause menu dedicated to cutscenes
#Ideally, it pauses a cutscene and can skip it

export var nextlevel = "res://src/levels/LevelTemplate.tscn"

func _process(_delta):
	if Input.is_action_just_pressed("ui_cancel"):
		toggle()

	if get_tree().paused == true:
		if Input.is_action_just_pressed("menuvisible"):
			visible = !visible

func toggle():
	visible = !visible
	get_tree().paused = visible

func _ready():
	hide()


func _on_UnpauseButton_pressed():
	hide()
	get_tree().paused = false


func _on_SkipCutscene_pressed():
	SceneManager.change_scene("level_transition_effect", nextlevel)


func _on_EN_Setting_pressed():
	TranslationServer.set_locale("en")


func _on_PT_Setting_pressed():
	TranslationServer.set_locale("pt")
