extends Node2D


onready var sprite = $KinematicBody2D/AnimatedSprite
export var spritename = "nortubel"
onready var animationplayer = $AnimationPlayer
#I GUESS THE POSITIONS IN THE ANIMATION AREN'T AN ISSUE RIGHT?
#MAYBE IT'S BECAUSE THEY'RE BASED OFF THE KINEMATICBODY NODE AND NOT THE MAIN SCENE

func _ready():
	animationplayer.play("RESET")
	sprite.animation = spritename
	Signals.connect("red_button_active", self, "_red_gate_opens")
	Signals.connect("red_button_unactive", self, "_red_gate_closes")

func _red_gate_opens():
	animationplayer.play("open")


func _red_gate_closes():
	animationplayer.play_backwards("open")
