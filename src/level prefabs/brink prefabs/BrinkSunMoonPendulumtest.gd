extends Node2D


onready var cloud = $BrinkSunmoonStarsThing/Cloud
onready var anchor = $BrinkSunmoonStarsThing/Anchor

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(_delta):
	cloud.global_rotation_degrees = 0
	cloud.global_position = anchor.global_position
