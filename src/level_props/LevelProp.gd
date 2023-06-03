extends Node2D
tool

onready var sprite = $Sprite
export var propname = "nortprop blue chimney"


func _ready():
	sprite.animation = propname
