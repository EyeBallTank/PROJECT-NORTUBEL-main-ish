extends Area2D
#Door requires both characters to use it
#Maybe i could consider endlevel doors that don't need both characters depending on level design
export var new_scene = "res://src/levels/LevelTemplate2.tscn"
var playertouch = false
var comptouch = false

onready var actualpassword = $CanvasLayer/NinePatchRect/ActualPassword
export(String) var customtext = "000000"

func _ready():
	actualpassword.text = str (customtext)

func _physics_process(delta):
	if playertouch == true and comptouch == true:
		SceneManager.change_scene("level_transition_effect", new_scene)

func _on_Door_body_entered(body):
	if body.name == "Player":
		playertouch = true
	if body.name == "Companion":
		comptouch = true

func _on_Door_body_exited(body):
	if body.name == "Player":
		playertouch = false
	if body.name == "Companion":
		comptouch = false


func _on_Button_pressed():
	pass # Replace with function body.
