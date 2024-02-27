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

#NOTE: "THE HEIGHT CHAR PROP TEST" EXISTS SO SOMEWHAT PUT CERTAIN CHARACTERS TO SCALE
#EVEN THOUGH SOME CHARACTER SPRITES ARE RESIZED
#IT IS USEFUL WHEN IT COMES TO MAKING SPRITES FOR VARIOUS THINGS LIKE PROPS AND CHARACTERS
