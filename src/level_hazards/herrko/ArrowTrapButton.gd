extends Area2D

var is_pressed = false
onready var animatedsprite = $AnimatedSprite
onready var animationplayer = $AnimationPlayer


func _ready():
	animatedsprite.animation = "unpressed"
	animationplayer.play("UNPRESSED")

func _on_ArrowTrapButton_body_entered(body):
	if body.is_in_group("protagonists"):
		is_pressed = true
		animatedsprite.animation = "pressed"
#		animationplayer.play("PRESSED")
		Signals.emit_signal("arrow_button_active")


func _on_ArrowTrapButton_body_exited(body):
	if body.is_in_group("protagonists"):
		is_pressed = false
		animatedsprite.animation = "unpressed"
#		animationplayer.play("PRESSED")
		Signals.emit_signal("arrow_button_unactive")
