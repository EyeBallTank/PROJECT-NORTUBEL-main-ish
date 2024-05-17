extends StaticBody2D


onready var animationplayer = $AnimationPlayer

enum {
	GOLEFT,
	GORIGHT
}

var state = GORIGHT

func _ready():
	pass 
