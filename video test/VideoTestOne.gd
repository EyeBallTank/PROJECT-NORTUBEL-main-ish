extends Node2D


onready var video = $VideoPlayer
onready var animation = $AnimationPlayer


func _ready():
	pass 
	animation.play("RESET")



func _on_Area2D_body_entered(body):
	if body.name == "Player":
		video.play()
		animation.play("PRESSED")
