extends KinematicBody2D

#NOT YET
#MAY GIVE HER ACTUAL SPRITES AND STUFF SOON

export var gravity: = 2960
var velocity = Vector2.ZERO

onready var dialogue = $CanvasLayer

func _ready():
	dialogue.visible = false
	pass

func _physics_process(delta):
	velocity.y += gravity * delta
	velocity = move_and_slide_with_snap(velocity, Vector2.DOWN, Vector2.UP)

func _on_TalktoArea_body_entered(body):
	if body.name == "Player":
		dialogue.visible = true

func _on_TalktoArea_body_exited(body):
	if body.name == "Player":
		dialogue.visible = false
