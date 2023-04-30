extends StaticBody2D

onready var animationplayer = $AnimationPlayer

func _ready():
	$AnimationPlayer.play("RESET")
	pass


func _on_BallDetector_area_entered(area):
	if area.name == "GoalDetector":
		$AudioStreamPlayer.play()
		animationplayer.play("ballreceived")
#		yield(get_tree().create_timer(1), "timeout")
#		queue_free()

func disappear():
	queue_free()
