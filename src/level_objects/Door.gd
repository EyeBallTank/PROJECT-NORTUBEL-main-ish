extends Area2D
#Door requires both characters to use it
#Maybe i could consider endlevel doors that don't need both characters depending on level design
export var new_scene = "res://src/levels/LevelTemplate2.tscn"
var playertouch = false
var comptouch = false

onready var sprite = $Sprite
export var spritename = "nortubel greendoor"

onready var actualpassword = $CanvasLayer/NinePatchRect/Control/ActualPassword
export(String) var customtext = "000000"
onready var dialoguebox = $CanvasLayer

func _ready():
	dialoguebox.visible = false
	actualpassword.text = str (customtext)
	sprite.animation = spritename

func _physics_process(delta):
	if playertouch == true and comptouch == true:
		dialoguebox.visible = true
		if Input.is_action_just_pressed("pressespace"):
			SceneManager.change_scene("level_transition_effect", new_scene)
	elif playertouch == false and comptouch == false:
		dialoguebox.visible = false

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
