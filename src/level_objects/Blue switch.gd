extends Area2D

var is_pressed = false

#onready var BluePlatHoriz = get_parent().get_node("BluePlatHoriz")
onready var animationplayer = $AnimationPlayer

func _ready():
	$Sprite.animation = "switchon"
	pass

func _on_Blue_switch_body_entered(body):
	if body.is_in_group("protagonists"):
#		if Input.get_action_strength("attack"):
		is_pressed = true
		animationplayer.play("PRESSED")
		$AudioStreamPlayer.play()
		$Sprite.animation = "switchoff"
		Signals.emit_signal("blue_switch_pressed")
		print("BLUE IS PRESSED")
	else:
		pass
