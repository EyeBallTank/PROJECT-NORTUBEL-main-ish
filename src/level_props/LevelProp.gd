extends Node2D

onready var sprite = $Sprite
export var propname = "nortprop blue chimney"


func _ready():
	sprite.animation = propname
