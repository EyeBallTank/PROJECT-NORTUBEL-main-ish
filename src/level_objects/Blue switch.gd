extends Area2D

func _ready():
	pass 


func _on_Blue_switch_body_entered(body):
	if body.name == "Player":
		if Input.is_action_pressed("down"):
			print("BLUE SWITCH PRESSED")
		else:
			pass
