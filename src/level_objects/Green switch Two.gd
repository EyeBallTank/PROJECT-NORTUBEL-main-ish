extends Area2D

var is_pressed = false

onready var animationplayer = $AnimationPlayer

func _ready():
	Signals.connect("green_switch_one_pressed", self, "_on_GreenSwitchOne_pressed")

func _on_GreenSwitchTwo_body_entered(body):
		if body.is_in_group("protagonists"):
			is_pressed = true
			animationplayer.play("PRESSED")
			Signals.emit_signal("green_switch_two_pressed")

func _on_GreenSwitchOne_pressed():
	animationplayer.play("UNPRESSED")
	is_pressed = false
