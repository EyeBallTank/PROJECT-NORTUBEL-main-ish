extends Area2D

var is_pressed = false

onready var BluePlatHoriz = get_parent().get_node("BluePlatHoriz")

func _ready():
	pass # Replace with function body.

func _on_Blue_switch_body_entered(body):
	if body.name == "Player":
#		if Input.get_action_strength("attack"):
		is_pressed = true
		Signals.emit_signal("blue_switch_pressed")
		print("BLUE IS PRESSED")
	else:
		pass
