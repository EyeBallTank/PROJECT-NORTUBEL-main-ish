extends Node2D

onready var animationplayer = $AnimationPlayer
onready var sound = $AudioStreamPlayer

func _ready():
	animationplayer.play("RESET")



func _on_Flowerswitch_body_entered(body):
	if body.is_in_group("protagonists"):
		sound.play()
		animationplayer.play("growing")
		yield(get_tree().create_timer(16), "timeout")
		animationplayer.play_backwards("growing")
		yield(animationplayer, "animation_finished")
		animationplayer.play("RESET")
