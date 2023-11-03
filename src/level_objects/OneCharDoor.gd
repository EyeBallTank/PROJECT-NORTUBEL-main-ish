extends Area2D
#Door that only requires 1 character, used in specific levels
export var new_scene = "res://src/levels/LevelTemplate2.tscn"
var playertouch = false

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
	if playertouch == true:
		dialoguebox.visible = true
		if Input.is_action_just_pressed("pressespace"):
			SceneManager.change_scene("level_transition_effect", new_scene)
	elif playertouch == false:
		dialoguebox.visible = false


func _on_OneCharDoor_body_entered(body):
	if body.name == "Player":
		playertouch = true

func _on_OneCharDoor_body_exited(body):
	if body.name == "Player":
		playertouch = false
