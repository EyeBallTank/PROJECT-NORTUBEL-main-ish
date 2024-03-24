extends Node2D

onready var animation = $AnimationPlayer 

var phase = 1

#Just in case
func _ready():
	animation.play("RESET")

func send_a_signal():
	Signals.emit_signal("collectible_picked")
