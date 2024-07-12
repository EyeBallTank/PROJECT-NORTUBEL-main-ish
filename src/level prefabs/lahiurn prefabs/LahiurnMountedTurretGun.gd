extends KinematicBody2D

var honk = false
onready var animation = $AnimationPlayer
onready var gunhole = $Position2D

const Bullet = preload("res://src/enemies/krimbstone/FriendlyBullet.tscn")

func _ready():
	animation.play("RESET")

func _physics_process(delta):
	if honk == true:
		if Input.is_action_just_pressed("standstill"):
			animation.play("fire gun")

func attack():
	var projectile = Bullet.instance()
	projectile.global_position = gunhole.global_position
	projectile.velocity.x = projectile.speed * 10
	get_tree().get_root().add_child(projectile)

func _on_UseIt_body_entered(body):
	if body.name == "Player":
		honk = true

func _on_UseIt_body_exited(body):
	if body.name == "Player":
		honk = false
