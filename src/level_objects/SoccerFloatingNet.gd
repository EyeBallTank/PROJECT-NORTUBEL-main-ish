extends KinematicBody2D

onready var animationplayer = $AnimationPlayer
export var sides = 1

func _ready():
	animationplayer.play("RESET")
	if sides == 1:
		pass
	elif sides == 2:
		scale.x = -scale.x

func disappear():
	queue_free()


func _on_BallDetector_area_exited(area):
	if area.name == "GoalDetector":
		$AudioStreamPlayer.play()
		animationplayer.play("ballreceived")

func _on_BallDetector_body_entered(body):
	if body.name == "SoccerBall":
		$AudioStreamPlayer.play()
		animationplayer.play("ballreceived")
