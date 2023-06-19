extends StaticBody2D

onready var sprite = $AnimatedSprite

func _ready():
	sprite.animation = "inside"
