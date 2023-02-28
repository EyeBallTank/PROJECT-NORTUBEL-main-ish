extends KinematicBody2D

onready var animationplayer = $AnimationPlayer

var is_fall
var motion = Vector2()
onready var positionorigin = global_position

func _physics_process(delta):
	if is_fall == false:
		motion.y += 20
	elif is_fall == true:
		position = positionorigin
		motion.y = 0
	motion = move_and_slide(motion, Vector2.UP)

func _ready():
	pass 

func _on_Area2D_body_entered(body):
	if body.is_in_group("protagonists"):
		animationplayer.play("shake")

func fall():
	is_fall = false
	print("fall")

func _on_Area2D_body_exited(body):
	$Timer.wait_time = 2
	$Timer.start()


func _on_Timer_timeout():
	is_fall = true
