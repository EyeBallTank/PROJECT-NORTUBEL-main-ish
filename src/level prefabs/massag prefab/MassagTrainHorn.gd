extends Node2D


onready var animation = $AnimationPlayer
onready var play = $Area2D
var canplay = false

func _ready():
	animation.play("RESET")

func _physics_process(delta):
	pass

	if canplay == true:
		if Input.is_action_pressed("kickball") and Input.is_action_just_pressed("standstill"):
			animation.play("played")
		if Input.is_action_just_pressed("followme"):
			animation.play("played")
		if Input.is_action_just_pressed("attack"):
			animation.play("played")


func _on_Area2D_body_entered(body):
	if body.name == "Player":
		canplay = true


func _on_Area2D_body_exited(body):
	if body.name == "Player":
		canplay = false
