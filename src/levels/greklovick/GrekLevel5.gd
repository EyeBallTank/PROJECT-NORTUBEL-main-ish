extends Node2D

onready var animation = $AnimationPlayer


#The leve could use a script of its own

func _ready():
	pass 


func send_a_signal():
	Signals.emit_signal("turn_off_zhark_shield")
