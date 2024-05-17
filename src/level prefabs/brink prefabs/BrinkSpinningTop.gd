extends StaticBody2D

#could be better
onready var animationplayer = $AnimationPlayer

enum {
	GOLEFT,
	GORIGHT
}

var state = GORIGHT

func _ready():
#	animationplayer.play("RESET")
	state = GORIGHT

func _physics_process(delta):
	match state:
		GOLEFT:
			constant_linear_velocity = Vector2(-80, 0)
		GORIGHT:
			constant_linear_velocity = Vector2(80, 0)

func changetoleft():
	state = GOLEFT

func changetoright():
	state = GORIGHT


func _on_MakeYouSpin_body_entered(body):
	if body.is_in_group("protagonists"):
		animationplayer.play("RESET")
