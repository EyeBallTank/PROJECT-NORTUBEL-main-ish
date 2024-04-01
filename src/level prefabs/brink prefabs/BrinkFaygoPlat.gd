extends Node2D
onready var animationplayer = $AnimationPlayer

enum {
	FROZENPLAT,
	ACTIVEPLAT
}

var state = FROZENPLAT

func _ready():
	animationplayer.play("IdlePlat")
	Signals.connect("trade_item_received", self, "_i_receive_trade_item_faygo")

func _process(delta):
	match state:
		FROZENPLAT:
			pass
		ACTIVEPLAT:
			animationplayer.play("HorizontalPlat")

func _i_receive_trade_item_faygo():
	Signals.emit_signal("blue_plat_horiz_active")
	state = ACTIVEPLAT
