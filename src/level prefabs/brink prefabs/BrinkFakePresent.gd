extends KinematicBody2D

onready var animationplayer = $AnimationPlayer


func _ready():
	animationplayer.play("RESET")


func _on_Area2D_area_entered(area):
	if area.name == "PlayerMelee":
		animationplayer.play("PRANK")
