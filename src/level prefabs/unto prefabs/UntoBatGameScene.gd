extends Node2D

var i_can_make_bat_jump = false


func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	if i_can_make_bat_jump == true:
		if Input.is_action_just_pressed("standstill"):
			Signals.emit_signal("bat_must_jump")
		if Input.is_action_just_pressed("runaway"):
			Signals.emit_signal("bat_must_really_jump")
	elif i_can_make_bat_jump == false:
		pass

func _on_Button_body_entered(body):
	if body.name == "Player":
		i_can_make_bat_jump = true


func _on_Button_body_exited(body):
	if body.name == "Player":
		i_can_make_bat_jump = false
