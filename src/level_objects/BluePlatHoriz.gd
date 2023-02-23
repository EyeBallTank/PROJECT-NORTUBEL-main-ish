extends Node2D

onready var animationplayer = $AnimationPlayer

enum {
	FROZENPLAT,
	ACTIVEPLAT
}

var state = FROZENPLAT

func _ready():
	animationplayer.play("IdlePlat")
	pass

func _process(delta):
	match state:
		FROZENPLAT:
			pass
		ACTIVEPLAT:
			animationplayer.play("HorizontalPlat")

func is_active():
	print("IS ACTIVE")
	state = ACTIVEPLAT
	
