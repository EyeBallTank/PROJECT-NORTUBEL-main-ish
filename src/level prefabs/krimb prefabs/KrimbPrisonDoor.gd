extends StaticBody2D

onready var animationplayer = $AnimationPlayer

func _ready():
	$AnimationPlayer.play("RESET")
	Signals.connect("blue_switch_pressed", self, "_on_BlueSwitch_pressed")

func _on_BlueSwitch_pressed():
	animationplayer.play("unlocked")

func disappear():
	queue_free()
