extends Area2D

var is_pressed = false

onready var animationplayer = $AnimationPlayer
export var gre2switchskin = "res://assets/sprites/level_object_sprites/Green switch Two.tres"

func _ready():
	$Sprite.animation = "switchoff"
	$Sprite.frames = load(gre2switchskin)
	Signals.connect("green_switch_one_pressed", self, "_on_GreenSwitchOne_pressed")

func _on_GreenSwitchTwo_body_entered(body):
		if body.is_in_group("protagonists"):
			is_pressed = true
			animationplayer.play("PRESSED")
			$AudioStreamPlayer.play()
			$Sprite.animation = "switchoff"
			Signals.emit_signal("green_switch_two_pressed")

func _on_GreenSwitchOne_pressed():
	yield(get_tree().create_timer(1), "timeout")
	animationplayer.play("UNPRESSED")
	$Sprite.animation = "switchon"
	is_pressed = false
