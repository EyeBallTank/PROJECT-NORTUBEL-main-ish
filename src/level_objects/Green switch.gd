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
		is_pressed = true
