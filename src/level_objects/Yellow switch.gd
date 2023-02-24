extends Area2D

var is_pressed = false


func _ready():
	pass


func _on_YellowSwitch_body_entered(body):
	if body.name == "Player":
		is_pressed = true
		print("YELLOW IS PRESSED")
		yield(get_tree().create_timer(3), "timeout")
		print("YELLOW IS UNPRESSED AGAIN")
