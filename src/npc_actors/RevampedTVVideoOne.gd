extends KinematicBody2D


onready var basicmessage = $Basicmessage
onready var dialoguebox = $CanvasLayer
onready var video = $CanvasLayer/VideoPlayer
onready var animation = $AnimationPlayer

var test = false


func _ready():
	dialoguebox.visible = false
	basicmessage.visible = false

func tv_pauses_the_game():
	get_tree().paused = true

func tv_unpauses_the_game():
	get_tree().paused = false

func _physics_process(_delta):
	if test == true:
		if Input.is_action_just_pressed("standstill") and dialoguebox.visible == false:
			dialoguebox.visible = true
			video.play()
			tv_pauses_the_game()
#			get_tree().paused == true
	elif test == false:
		dialoguebox.visible = false
		video.stop()
#		tv_unpauses_the_game()
#		get_tree().paused == false
	if Input.is_action_just_pressed("runaway") and dialoguebox.visible == true:
		test = false
#		video.stop()
		tv_unpauses_the_game()
	elif Input.is_action_just_pressed("runaway") and dialoguebox.visible == false:
		pass


	if Input.is_action_just_pressed("ui_cancel") and dialoguebox.visible == true:
		test = false
		tv_pauses_the_game()
	elif Input.is_action_just_pressed("ui_cancel") and dialoguebox.visible == false:
		pass


func _on_TalktoArea_body_entered(body):
	if body.name == "Player":
		basicmessage.visible = true
		test = true

func _on_TalktoArea_body_exited(body):
	if body.name == "Player":
		basicmessage.visible = false
		test = false

