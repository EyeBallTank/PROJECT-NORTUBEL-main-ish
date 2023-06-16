extends StaticBody2D

onready var animatedsprite = $AnimatedSprite
onready var animatedplayer = $AnimationPlayer


func _ready():
	animatedsprite.animation = "closed"
	animatedplayer.play("closed")
	Signals.connect("floor_switch_active", self, "_on_FloorSwitch_Active")


func _on_FloorSwitch_Active():
	animatedplayer.play("opening")
	Signals.emit_signal("floor_switch_barrier_opens")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
