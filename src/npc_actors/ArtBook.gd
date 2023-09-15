extends KinematicBody2D

onready var dialoguebox = $CanvasLayer
export var boardname = "placeholder"
onready var sprite = $CanvasLayer/AnimatedSprite
onready var basicmessage = $Basicmessage

var test = false

func _ready():
	sprite.animation = boardname
	dialoguebox.visible = false
	basicmessage.visible = false

func _physics_process(delta):
	if test == true:
		if Input.is_action_just_pressed("standstill") and dialoguebox.visible == false:
			dialoguebox.visible = true
	elif test == false:
		dialoguebox.visible = false
	if Input.is_action_just_pressed("runaway"):
		test = false



func _on_TalktoArea_body_entered(body):
	if body.name == "Player":
		basicmessage.visible = true
		test = true

func _on_TalktoArea_body_exited(body):
	if body.name == "Player":
		basicmessage.visible = false
		test = false
