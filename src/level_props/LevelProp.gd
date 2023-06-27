extends Node2D
tool

onready var sprite = $Sprite
export var propname = "nortprop blue chimney"
export var flipstate_h = false
export var flipstate_v = false
export var newrotation = 0

func _ready():
	sprite.animation = propname
	sprite.flip_h = flipstate_h
	sprite.flip_v = flipstate_v
	sprite.global_rotation = newrotation
