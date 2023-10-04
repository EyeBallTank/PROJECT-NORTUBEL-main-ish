extends KinematicBody2D

onready var animation = $AnimationPlayer

func _ready():
	animation.play("default")


func die():
	queue_free()


func _on_PopupHurtbox_area_entered(area):
	if area.name == "PlayerMelee":
		animation.play("dying")
	if area.name == "EnemyCrusher":
		animation.play("dying")
