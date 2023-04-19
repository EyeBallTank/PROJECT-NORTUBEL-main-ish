extends Area2D

var is_pressed = false

onready var animationplayer = $AnimationPlayer

func _ready():
	$Sprite.animation = "switchon"
	Signals.connect("green_switch_two_pressed", self, "_on_GreenSwitchTwo_pressed")

func _on_GreenSwitchOne_body_entered(body):
		if body.is_in_group("protagonists"):
			is_pressed = true
			animationplayer.play("PRESSED")
			$AudioStreamPlayer.play()
			$Sprite.animation = "switchoff"
			Signals.emit_signal("green_switch_one_pressed")

func _on_GreenSwitchTwo_pressed():
	yield(get_tree().create_timer(1), "timeout")
	animationplayer.play("UNPRESSED")
	$Sprite.animation = "switchon"
	is_pressed = false
