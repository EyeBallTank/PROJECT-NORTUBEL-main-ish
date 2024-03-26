extends Node2D

onready var animationplayer = $AnimationPlayer
export var animation = "mainloop"

func _ready():
	animationplayer.play(animation)

func die():
	queue_free()

func _on_hurtbox_area_entered(area):
	if area.name == "PlayerMelee":
		animationplayer.play("dying")
