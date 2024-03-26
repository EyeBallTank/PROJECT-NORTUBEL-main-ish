extends KinematicBody2D
class_name UulgaMain

enum {
	FOLLOWME,
	STANDSTILL,
	RUNAWAY,
	ATTACKFROMFOLLOW,
	ATTACKFROMRUN,
	ATTACKFROMIDLE
}

var state = STANDSTILL


func _ready():
	pass 

func return_to_move():
	if state == ATTACKFROMFOLLOW:
		FOLLOWME
	elif state == ATTACKFROMRUN:
		RUNAWAY
	elif state == ATTACKFROMIDLE:
		STANDSTILL
