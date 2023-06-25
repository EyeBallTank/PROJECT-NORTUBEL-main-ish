extends KinematicBody2D


var direction = Vector2.UP
var velocity = Vector2.ZERO
onready var sprite = $AnimatedSprite
onready var timer = $Timer
onready var mouth = $Position2D

var PROJECTILE_VELOCITY = 1000
const Fireball = preload("res://src/enemies/FishProjectile.tscn")

func _ready():
	timer.start(1.5)
	sprite.animation = "closedmouth"

func _physics_process(delta):
	var hitceiling = is_on_ceiling()
	var hitfloor = is_on_floor()
	if hitfloor:
		direction *= -1
		sprite.flip_h = false
		mouth.position = Vector2( 0, 0)
	if hitceiling:
		direction *= -1
		sprite.flip_h = true
		mouth.position = Vector2( -240, 0)
	velocity = direction * 290
	move_and_slide(velocity, Vector2.UP)
	if timer.time_left == 0:
		attack()
		timer.start(1.5)

func attack():
	var projectile = Fireball.instance()
	projectile.global_position = mouth.global_position
#	projectile.linear_velocity = Vector2(direction * PROJECTILE_VELOCITY, 0)
	get_tree().get_root().add_child(projectile)
	print("spit")
