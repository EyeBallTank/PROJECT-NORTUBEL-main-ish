extends Area2D

var is_pressed = false
onready var animatedsprite = $AnimatedSprite
onready var animationplayer = $AnimationPlayer

export var floorswitchskin = "res://assets/sprites/level_object_sprites/FloorSwitch.tres"


func _ready():
	animatedsprite.frames = load(floorswitchskin)
	animatedsprite.animation = "unpressed"
	animationplayer.play("UNPRESSED")


func _on_FloorSwitch_body_entered(body):
	if body.is_in_group("pushable"):
		is_pressed = true
		animatedsprite.animation = "pressed"
		animationplayer.play("PRESSED")
		Signals.emit_signal("floor_switch_active")
	else:
		pass
