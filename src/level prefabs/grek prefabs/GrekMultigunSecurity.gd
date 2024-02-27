extends KinematicBody2D

var honk = false
onready var dialogue = $CanvasLayer
onready var elecplace = $Position2D
onready var animation = $AnimationPlayer
onready var audio = $AudioStreamPlayer

const Electricity = preload("res://src/level prefabs/grek prefabs/GrekMultigunElec.tscn")


func _ready():
	dialogue.visible = false
	animation.play("RESET")

func _physics_process(delta):
	if honk == true:
		if Input.is_action_pressed("kickball") and Input.is_action_just_pressed("standstill"):
			animation.play("active")
		if Input.is_action_just_pressed("followme"):
			animation.play("active")
		if Input.is_action_just_pressed("attack"):
			animation.play("active")

func _on_TalkToArea_body_entered(body):
	if body.name == "Player":
		dialogue.visible = true
		honk = true

func _on_TalkToArea_body_exited(body):
	if body.name == "Player":
		dialogue.visible = false
		honk = false

func attack():
	var projectile = Electricity.instance()
	projectile.global_position = elecplace.global_position
	get_tree().get_root().add_child(projectile)
