extends KinematicBody2D

enum {
	FROZENPLAT,
	ACTIVEPLAT
}

var state = FROZENPLAT

func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	match state:
		FROZENPLAT:
			pass
		ACTIVEPLAT:
			print("IS ACTIVE")

func is_active():
	state = ACTIVEPLAT
