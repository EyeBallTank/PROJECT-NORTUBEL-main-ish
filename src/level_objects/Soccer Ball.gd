extends RigidBody2D
class_name SoccerBall
#code taken and edited from that KinematicBody2D demo
onready var animationplayer = $AnimationPlayer

func _ready():
	pass

func ball_disappear():
	animationplayer.play("Ballvanish")
	yield(get_node("AnimationPlayer"), "animation_finished")
	queue_free()

#func _on_body_entered(body):
#	if body is Enemy:
#		body.destroy()
