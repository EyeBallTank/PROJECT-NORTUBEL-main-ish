extends Area2D

onready var audioPlayer = $AudioStreamPlayer
onready var animationplayer = $AnimationPlayer
onready var sprite = $Sprite
export var spritename = "nortubel floater"

func _ready():
	sprite.animation = spritename
	animationplayer.play("RESET")
	pass


func _on_LifeguardFloater_body_entered(body):
	if body.is_in_group("protagonists"):
#		body.is_invul()
		Signals.emit_signal("you_are_invincible")
		audioPlayer.play()
		animationplayer.play("caught")
#		yield(animationplayer, "animation_finished")
#		queue_free()

func disappear():
	queue_free()
