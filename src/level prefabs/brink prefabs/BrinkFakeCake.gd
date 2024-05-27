extends StaticBody2D

onready var animationplayer = $AnimationPlayer
onready var sound = $AudioStreamPlayer


func _ready():
	animationplayer.play("RESET")



func _on_accept_knife_area_entered(area):
	if area.name == "PlayerMelee":
		animationplayer.play("pop")
		sound.play()
