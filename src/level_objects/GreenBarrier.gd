extends StaticBody2D

onready var animatedsprite = $AnimatedSprite
onready var animatedplayer = $AnimationPlayer
export var animation1 = "OPEN"
export var animation2 = "CLOSED"


func _ready():
	animatedplayer.play(animation2)
	Signals.connect("green_switch_one_pressed", self, "_on_GreenSwitchOne_pressed")
	Signals.connect("green_switch_two_pressed", self, "_on_GreenSwitchTwo_pressed")

func _on_GreenSwitchOne_pressed():
	animatedplayer.play(animation1)

func _on_GreenSwitchTwo_pressed():
	animatedplayer.play(animation2)
