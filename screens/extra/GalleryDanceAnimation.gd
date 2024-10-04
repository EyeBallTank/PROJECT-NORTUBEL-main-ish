extends CanvasLayer


onready var buttonanimation = $ButtonsAnimation


func _ready():
	buttonanimation.play("RESET")


func _on_ON_BUTTON_pressed():
	buttonanimation.play("dance is on")


func _on_OFF_BUTTON_pressed():
	buttonanimation.play("RESET")
