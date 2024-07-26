extends StaticBody2D

onready var animation = $AnimationPlayer

func _ready():
	animation.play("RESET")

func die():
	queue_free()


func _on_BulletCatcher_body_entered(body):
	if body.is_in_group("goodbullet"):
		animation.play("wall_is_gone")
