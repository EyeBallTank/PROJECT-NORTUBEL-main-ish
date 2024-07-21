extends Node2D

onready var animation = $AnimationPlayer



func _ready():
	animation.play("RESET")



func _on_eyes_body_entered(body):
	if body.name == "Player":
		animation.play("camera saw")
		Signals.emit_signal("katrin_was_seen")
