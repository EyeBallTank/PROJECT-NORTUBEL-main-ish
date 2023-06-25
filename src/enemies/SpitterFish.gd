extends KinematicBody2D


var direction = Vector2.UP
var velocity = Vector2.ZERO
onready var sprite = $AnimatedSprite
onready var timer = $Timer

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
	if hitceiling:
		direction *= -1
		sprite.flip_h = true
	velocity = direction * 290
	move_and_slide(velocity, Vector2.UP)
	if timer.time_left == 0:
		attack()
		timer.start(1.5)

func attack():
	var projectile = Fireball.instance()
	projectile.global_position = self.global_position
#	projectile.linear_velocity = direction * PROJECTILE_VELOCITY
	get_tree().get_root().add_child(projectile)
	print("spit")
