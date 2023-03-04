extends RigidBody2D
class_name SoccerBall
#code taken and edited from that KinematicBody2D demo
onready var animationplayer = $AnimationPlayer

func _ready():
	ball_disappear()

func ball_disappear():
	yield(get_tree().create_timer(2), "timeout")
	animationplayer.play("Ballvanish")
	yield(get_node("AnimationPlayer"), "animation_finished")
	queue_free()

#func _on_body_entered(body):
#	if body is Enemy:
#		body.destroy()
