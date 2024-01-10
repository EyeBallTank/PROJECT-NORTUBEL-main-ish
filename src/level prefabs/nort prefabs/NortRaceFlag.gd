extends Area2D

onready var animation = $AnimationPlayer

func _ready():
	animation.play("RESET")

func _on_NortRaceFlag_body_entered(body):
	if body.is_in_group("protagonists"):
		animation.play("playerwon")

	if body.is_in_group("rival"):
		animation.play("playerlost")
