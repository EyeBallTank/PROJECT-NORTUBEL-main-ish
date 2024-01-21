extends Area2D
tool

onready var animationplayer = $AnimationPlayer
onready var sprite = $Sprite
export var spritename = "B"


func _ready():
	sprite.animation = spritename

func disappear():
	queue_free()

func send_a_signal():
	Signals.emit_signal("collectible_picked")

func _on_BrinkBonkaLetterPickup_body_entered(body):
	if body.is_in_group("protagonists"):
		animationplayer.play("collected")
