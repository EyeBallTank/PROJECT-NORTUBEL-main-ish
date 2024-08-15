extends Node2D

onready var animation = $AnimationPlayer





func _ready():
	animation.play("RESET")
	Signals.connect("the_bat_has_won", self, "_the_bat_opens_the_door")



func _the_bat_opens_the_door():
	animation.play("open")
