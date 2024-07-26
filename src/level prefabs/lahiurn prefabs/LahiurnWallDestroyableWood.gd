extends StaticBody2D

onready var animation = $AnimationPlayer

var health = 5

func _ready():
	animation.play("RESET")

func die():
	queue_free()

#func _physics_process(delta):
#	if health == 0:
#		animation.play("wall_is_gone")

func _on_BulletCatcher_body_entered(body):
	if body.is_in_group("goodbullet"):
#		health =- 1
		animation.play("wall_is_gone")
