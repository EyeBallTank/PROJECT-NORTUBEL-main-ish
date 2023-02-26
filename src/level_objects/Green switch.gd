extends Area2D

var is_pressed = false

enum {
	PRESSONE,
	PRESSTWO
}

var state = PRESSONE

func _ready():
	pass

func _process(delta):
	match state:
		PRESSONE:
			pass
		PRESSTWO:
			pass

func _on_GreenSwitch_body_entered(body):
	if body.name == "Player":
		if state == PRESSONE:
			is_pressed = true
			print("GREEN WAS PRESSED ONCE")
			state = PRESSTWO
		if state == PRESSTWO:
			is_pressed = false
			print("GREEN WAS PRESSED TWICE")
			state = PRESSONE

#print("GREEN PRESSONE")
#print("GREEN PRESSTWO")
