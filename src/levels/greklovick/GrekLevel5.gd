extends Node2D

onready var animation = $AnimationPlayer
onready var shieldgen1 = $ShieldGenerator1

var switchespressed = 0


#The leve could use a script of its own

func _ready():
	pass 

#func _physics_process(delta):
#	if switchespressed == 2:
#		send_a_signal()

func send_a_signal():
	Signals.emit_signal("turn_off_zhark_shield")

func switch_pressed():
	switchespressed += 1

func _on_ButtonPress_body_entered(body):
	if body.is_in_group("protagonists"):
		switch_pressed()
