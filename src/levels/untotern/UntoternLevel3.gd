extends Node2D


onready var background = $ParallaxBackground2


func _ready():
	pass # Replace with function body.

func _process(delta):
	background.scroll_base_offset -= Vector2(250, 0) * delta
