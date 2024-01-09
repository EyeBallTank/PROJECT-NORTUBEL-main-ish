extends Node2D

onready var background = $ParallaxBackground


func _process(delta):
	background.scroll_base_offset -= Vector2(200, 0) * delta

func _ready():
	pass 
