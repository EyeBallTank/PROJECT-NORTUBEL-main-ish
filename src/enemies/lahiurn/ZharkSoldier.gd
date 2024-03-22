extends KinematicBody2D


export var gravity: = 23600

var direction = Vector2.RIGHT
var velocity = Vector2.ZERO

onready var sprite: = $AnimatedSprite
onready var floordetect = $Floordetect
onready var eyes = $Eyes

onready var animation = $AnimationPlayer
onready var timer = $Timer #2 seconds
onready var gunhole = $Position2D
onready var bombspawn = $BombSpawn
var canattack = false
var canmove = true

#const Bullet = preload("res://src/enemies/lahiurn/EygzouhlFire.tscn")
#const FloorFire = preload("res://src/enemies/lahiurn/EygzouhlFloorFire.tscn")
#const BulletLeft = preload("res://src/enemies/lahiurn/EygzouhlFireLeft.tscn")
#

enum {
	MOVING,
	SHOOT,
	DEAD
}

var state = MOVING

func _ready():
	animation.play("RESET")

func _physics_process(delta):
	match state:
		MOVING:
			if see_to_attack():
				state = SHOOT

		SHOOT:
			pass

func attack():
	pass

func detect_turn_around():
	if not floordetect.is_colliding() and is_on_floor():
		direction *= -1
#		sprite.flip_h = direction.x < 0
		scale.x = -scale.x

func die():
	queue_free()

func see_to_attack():
	if not eyes.is_colliding(): return false
	var collider = eyes.get_collider()
	if not collider.is_in_group("protagonists"): return false
#	if not collider is StellaMain: return false
#	if not collider is Companion: return false
	return true

func return_to_move():
	state = MOVING
