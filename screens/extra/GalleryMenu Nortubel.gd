extends Control

onready var sprite = $AnimatedSprite

export var number = 25

var currentFrame: int = 0

func _ready():
	pass 

func _process(delta):
	if Input.is_action_just_pressed("pressespace"):
		currentFrame += 1
		if currentFrame > number:
			currentFrame = 0
		sprite.frame = currentFrame


func _on_TextureButton_pressed():
	SceneManager.change_scene("level_transition_effect", "res://screens/extra/Gallery.tscn")
