extends KinematicBody2D

#NOT YET
#MAY GIVE HER ACTUAL SPRITES AND STUFF SOON

export var gravity: = 2960
var velocity = Vector2.ZERO

func _ready():
	pass

func _physics_process(delta):
	velocity.y += gravity * delta
	velocity = move_and_slide_with_snap(velocity, Vector2.DOWN, Vector2.UP)
