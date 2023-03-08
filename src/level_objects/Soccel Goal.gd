extends StaticBody2D


func _ready():
	pass


func _on_BallDetector_area_entered(area):
	if area.name == "GoalDetector":
		yield(get_tree().create_timer(1), "timeout")
		queue_free()
