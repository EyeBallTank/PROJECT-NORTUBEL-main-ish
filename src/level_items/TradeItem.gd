extends Area2D

onready var animationplayer = $AnimationPlayer
onready var sprite = $Sprite
export var spritename = "tradeitem krimb ricotto key"

func _ready():
	sprite.animation = spritename
	animationplayer.play("RESET")
	pass



func disappear():
	queue_free()


func _on_TradeItem_body_entered(body):
	if body.name == "Player":
		body.hastradeitem = true
		animationplayer.play("caughtkey")
