extends Node2D

onready var animation = $AnimationPlayer
onready var shieldgen1 = $ShieldGenerator1


#The leve could use a script of its own

func _ready():
	pass 


func send_a_signal():
	Signals.emit_signal("turn_off_zhark_shield")


func _on_ButtonPress_body_entered(body):
	if body.is_in_group("protagonists"):
		send_a_signal()
