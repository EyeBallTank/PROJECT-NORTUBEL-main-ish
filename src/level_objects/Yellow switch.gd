extends Area2D
tool

var is_pressed = false

#onready var YellowPlatVerti = get_parent().get_node("YellowPlatVerti")
onready var animationplayer = $AnimationPlayer
export var yelswitchskin = "res://assets/sprites/level_object_sprites/Yellow switch.tres"

func _ready():
	$Sprite.animation = "switchon"
	$Sprite.frames = load(yelswitchskin)

func _on_YellowSwitch_body_entered(body):
	if body.is_in_group("protagonists"):
		is_pressed = true
		print("YELLOW IS PRESSED")
		animationplayer.play("PRESSED")
		$AudioStreamPlayer.play()
		$Sprite.animation = "switchoff"
		Signals.emit_signal("yellow_switch_pressed")
#		yield(get_tree().create_timer(3), "timeout")
		yield(get_node("AnimationPlayer"), "animation_finished")
		is_pressed = false
		print("YELLOW IS UNPRESSED AGAIN")
		animationplayer.play("UNPRESSED")
		$Sprite.animation = "switchon"
