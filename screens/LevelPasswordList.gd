extends CanvasLayer


onready var animation = $AnimationPlayer



func _ready():
	animation.play("RESET")


func _on_TextureButton_pressed():
	animation.play("showsup")


func _on_TextureButton2_pressed():
	animation.play_backwards("showsup")
