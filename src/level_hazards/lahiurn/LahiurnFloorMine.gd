extends KinematicBody2D

onready var animation = $AnimationPlayer

onready var sound = $AudioStreamPlayer
onready var elecplace = $Position2D
const Electricity = preload("res://src/enemies/greklovick/TemporaryExplosion.tscn")

func _ready():
	animation.play("RESET")

func die():
	queue_free()

func attack():
#	sound.play()
	var projectile = Electricity.instance()
	projectile.global_position = elecplace.global_position
	get_tree().get_root().add_child(projectile)



func _on_StepOnMe_body_entered(body):
	if body.is_in_group("protagonists"):
		animation.play("goodbye")
