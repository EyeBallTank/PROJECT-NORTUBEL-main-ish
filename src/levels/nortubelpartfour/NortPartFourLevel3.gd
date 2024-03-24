extends Node2D

onready var animation = $AnimationPlayer 

var phase = 1

#Just in case
func _ready():
	animation.play("RESET")
	Signals.connect("hand_was_destroyed", self, "amalia_is_hurt")

func send_a_signal():
	Signals.emit_signal("collectible_picked")

func amalia_is_hurt():
	print("ouch")
