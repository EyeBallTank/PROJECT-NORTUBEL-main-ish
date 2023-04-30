extends RigidBody2D
class_name SoccerBall
#code taken and edited from that KinematicBody2D demo
onready var animationplayer = $AnimationPlayer
onready var audioplayer = $AudioStreamPlayer

var bounce_factor = 150

func _ready():
	animationplayer.play("RESET")
	ball_disappear()

func ball_disappear():
#	yield(get_tree().create_timer(2), "timeout")
	animationplayer.play("Ballvanish")
#	yield(get_node("AnimationPlayer"), "animation_finished")
#	queue_free()

#audioplayer.play()

func _on_SoccerBall_body_entered(_body):
	if abs(self.linear_velocity.x)>bounce_factor or abs(self.linear_velocity.y)>bounce_factor:
		audioplayer.play()

func disappear():
	queue_free()
