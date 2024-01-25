extends StaticBody2D
tool

onready var animationplayer = $AnimationPlayer

func _ready():
	$AnimationPlayer.play("RESET")
	pass



func _on_BallDetector_area_entered(area):
	if area.name == "GoalDetector":
		$AudioStreamPlayer.play()
		animationplayer.play("ballreceived")

func disappear():
	queue_free()

func send_a_signal():
	Signals.emit_signal("collectible_picked")
