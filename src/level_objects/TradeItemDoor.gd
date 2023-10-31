extends StaticBody2D

onready var animationplayer = $AnimationPlayer
onready var sprite = $Sprite
export var spritename = "tradeitemdoor krimbstone"


func _ready():
	Signals.connect("trade_item_received", self, "_i_receive_trade_item")
	sprite.animation = spritename
	$AnimationPlayer.play("RESET")
	pass

func _i_receive_trade_item():
	$AudioStreamPlayer.play()
	animationplayer.play("unlocked")

func disappear():
	queue_free()

