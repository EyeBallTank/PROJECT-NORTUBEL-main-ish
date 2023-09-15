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
	pass # Replace with function body.


func _on_TalktoArea_body_exited(body):
	pass # Replace with function body.
