extends Node2D

onready var animationplayer = $AnimationPlayer

func _ready():
	animationplayer.play("RESET")

func die():
	queue_free()




func _on_EnterHand_body_entered(body):
	if body.is_in_group("protagonists"):
		animationplayer.play("caught")


func _on_HURTBOX_area_entered(area):
	if area.name == "PlayerMelee":
		animationplayer.play("dead")
	if area.name == "EnemyCrusher":
		animationplayer.play("dead")
