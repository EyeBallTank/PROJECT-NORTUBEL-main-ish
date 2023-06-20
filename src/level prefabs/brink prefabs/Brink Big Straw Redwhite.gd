extends StaticBody2D

onready var sprite = $AnimatedSprite

func _ready():
	sprite.animation = "normal"


func _on_Area2D_body_entered(body):
	if body.is_in_group("protagonists"):
		sprite.animation = "inside"
