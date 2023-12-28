extends Node2D

onready var animationsprite = $AnimatedSprite
onready var animationplayer = $AnimationPlayer
onready var button = $button

func _ready():
	animationsprite.play("default")
	button.play("unpressed")


func _on_victory_button_body_entered(body):
	if body.is_in_group("player"):
		animationsprite.play("victory")
		animationplayer.play("truevictory")
		button.play("presssed")

func _on_loss1button_body_entered(body):
	if body.is_in_group("player"):
		animationsprite.play("loss1")
		animationplayer.play("itsover")
		button.play("presssed")

func _on_loss2button_body_entered(body):
	if body.is_in_group("player"):
		animationsprite.play("loss2")
		animationplayer.play("itsover")
		button.play("presssed")

func _on_loss3button_body_entered(body):
	if body.is_in_group("player"):
		animationsprite.play("loss3")
		animationplayer.play("itsover")
		button.play("presssed")
