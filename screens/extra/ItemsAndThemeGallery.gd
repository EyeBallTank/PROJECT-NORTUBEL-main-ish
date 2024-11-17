extends Control

export var number = 8
var currentFrame: int = 0

onready var sprite = $MenuBg

func _process(delta):
	if Input.is_action_just_pressed("kickball"):
		currentFrame += 1
		if currentFrame > number:
			currentFrame = 0
		sprite.frame = currentFrame

func _on_TextureButton_pressed():
	SceneManager.change_scene("level_transition_effect", "res://screens/extra/Gallery.tscn")
