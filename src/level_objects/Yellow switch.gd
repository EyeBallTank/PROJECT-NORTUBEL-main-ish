extends Area2D

var is_pressed = false

onready var YellowPlatVerti = get_parent().get_node("YellowPlatVerti")
onready var animationplayer = $AnimationPlayer

func _ready():
	pass

func _on_YellowSwitch_body_entered(body):
	if body.name == "Player":
		is_pressed = true
		print("YELLOW IS PRESSED")
		animationplayer.play("PRESSED")
		Signals.emit_signal("yellow_switch_pressed")
#		yield(get_tree().create_timer(3), "timeout")
		yield(get_node("AnimationPlayer"), "animation_finished")
		is_pressed = false
		print("YELLOW IS UNPRESSED AGAIN")
		animationplayer.play("UNPRESSED")
