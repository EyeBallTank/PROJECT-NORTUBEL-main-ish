extends Area2D

var is_pressed = false
onready var animatedsprite = $AnimatedSprite
onready var animationplayer = $AnimationPlayer

export var redbuttonskin = "res://assets/sprites/level_object_sprites/RedButton.tres"


func _ready():
	animatedsprite.frames = load(redbuttonskin)
	animatedsprite.animation = "unpressed"
	animationplayer.play("UNPRESSED")



func _on_RedButton_body_entered(body):
	if body.is_in_group("protagonists"):
		is_pressed = true
		animatedsprite.animation = "pressed"
#		animationplayer.play("PRESSED")
		Signals.emit_signal("red_button_active")
		print("it is on")


func _on_RedButton_body_exited(body):
	if body.is_in_group("protagonists"):
		is_pressed = false
		animatedsprite.animation = "unpressed"
#		animationplayer.play("PRESSED")
		Signals.emit_signal("red_button_unactive")
		print("not anymore")
