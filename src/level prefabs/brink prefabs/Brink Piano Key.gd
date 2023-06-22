extends StaticBody2D
#PITCH SCALES TO REMEMBER
#1
#1.13
#1.26
#1.34
#1.5
#1.68
#1.86
#1.99
onready var sprite = $AnimatedSprite
onready var audio = $AudioStreamPlayer
export var pitchscale = 1.0

func _ready():
	sprite.animation = "UNPRESSED"

func _on_Area2D_body_entered(body):
	if body.is_in_group("protagonists"):
		sprite.animation = "PRESSED"
		audio.play()
		audio.set_pitch_scale(pitchscale)


func _on_Area2D_body_exited(body):
	if body.is_in_group("protagonists"):
		sprite.animation = "UNPRESSED"
