extends Node2D

onready var animation = $AnimationPlayer
var can_be_used = false
var playertouch = false
var comptouch = false

func _ready():
	animation.play("RESET")


func _physics_process(delta):
	if playertouch == true or comptouch == true:
		can_be_used = true
	elif playertouch == false and comptouch == false:
		can_be_used = false
		animation.play("RESET")

	if can_be_used == true:
		if Input.is_action_just_pressed("jumpup") or Input.is_action_just_pressed("interactcomp"):
			animation.play("stays_on")
		elif Input.is_action_just_released("jumpup"):
			animation.play("RESET")


func _on_Area2D_body_entered(body):
	if body.name == "Player":
		playertouch = true
	if body.name == "Companion":
		comptouch = true


func _on_Area2D_body_exited(body):
	if body.name == "Player":
		playertouch = false
	if body.name == "Companion":
		comptouch = false

func _on_makejump_body_entered(body):
	if body.name == "Player":
		body.velocity.y = -3000
		body.move_and_slide(body.velocity)

	if body.name == "Companion":
		body.vel.y = -1500
		body.move_and_slide(body.vel)
