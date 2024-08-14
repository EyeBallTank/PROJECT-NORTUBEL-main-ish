extends StaticBody2D
tool

onready var animatedsprite = $AnimatedSprite
onready var animatedplayer = $AnimationPlayer
export var animation1 = "OPEN"
export var animation2 = "CLOSED"
export var greenbarrierskin = "res://assets/sprites/level_object_sprites/GreenBarrier.tres"

func _ready():
	animatedsprite.frames = load(greenbarrierskin)
	animatedplayer.play(animation2)
	Signals.connect("green_switch_one_pressed", self, "_on_GreenSwitchOne_pressed")
	Signals.connect("green_switch_two_pressed", self, "_on_GreenSwitchTwo_pressed")

func _on_GreenSwitchOne_pressed():
	animatedplayer.play(animation1)

func _on_GreenSwitchTwo_pressed():
	animatedplayer.play(animation2)
