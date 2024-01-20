extends StaticBody2D
tool

onready var animationplayer = $AnimationPlayer
export var sides = 1

func _ready():
	if sides == 1:
		pass
	elif sides == 2:
		scale.x = -scale.x
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

func send_a_signal():
	Signals.emit_signal("collectible_picked")
