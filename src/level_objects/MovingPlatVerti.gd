extends Node2D

onready var sprite = $Platform/Sprite
export var spritename = "nortubel movplatvert"

func _ready():
	sprite.animation = spritename
