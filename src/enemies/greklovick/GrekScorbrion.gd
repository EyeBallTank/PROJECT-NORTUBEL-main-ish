extends KinematicBody2D

export var gravity: = 23600

var direction = Vector2.RIGHT
var velocity = Vector2.ZERO
var BALL_VELOCITY = 1200.0

onready var sprite: = $AnimatedSprite
onready var floordetect = $Floordetect
onready var eyes = $Eyes
onready var animation = $AnimationPlayer
onready var timer = $Timer
onready var gunhole = $Position2D
var canattack = false
var canmove = true

#const Bullet = preload("res://src/enemies/greklovick/GrekGrenade.tscn")

enum {
	MOVING,
	SHOOT,
	DEAD
}

var state = MOVING

func _ready():
	pass

func _physics_process(delta):

	match state:
		MOVING:
			pass

		SHOOT:
			pass

		DEAD:
			pass

func detect_turn_around():
	if not floordetect.is_colliding() and is_on_floor():
		direction *= -1
		scale.x = -scale.x

func die():
	queue_free()

func see_to_attack():
	if not eyes.is_colliding(): return false
	var collider = eyes.get_collider()
	if not collider.is_in_group("protagonists"): return false
	return true

func return_to_move():
	state = MOVING
