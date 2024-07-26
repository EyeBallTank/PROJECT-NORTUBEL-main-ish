extends Node2D


onready var switchsprite = $YellowSwitch/AnimatedSprite
onready var animation = $AnimationPlayer
onready var audio = $AudioStreamPlayer

onready var elecplace = $Position2D
const Electricity = preload("res://src/level prefabs/krimb prefabs/TemporaryElec.tscn")

func _ready():
	switchsprite.play("switchoff")
	animation.play("RESET")

func attack():
	audio.play()
	var projectile = Electricity.instance()
	projectile.global_position = elecplace.global_position
	get_tree().get_root().add_child(projectile)



func _on_YellowSwitch_body_entered(body):
	if body.is_in_group("protagonists"):
		animation.play("active")
		
