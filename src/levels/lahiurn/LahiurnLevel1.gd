extends Node2D

onready var background = $ParallaxBackground2

func _process(delta):
	background.scroll_base_offset -= Vector2(-30, 0) * delta

func _ready():
	pass
