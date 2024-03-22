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

const ShotgunBlast = preload("res://src/enemies/greklovick/GrekShotgunPellets.tscn")
const Bomb = preload("res://src/enemies/greklovick/TemporaryExplosion.tscn")

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

			detect_turn_around()
			sprite.play("Idle")
			var found_wall = is_on_wall()
			if found_wall:
				direction *= -1
				scale.x = -scale.x
			velocity = direction * 300
			velocity.y += gravity * delta
			move_and_slide(velocity, Vector2.UP)
			gravity = 37600

		SHOOT:
			pass

		DEAD:
			pass

func attack():
	pass

func attack_post_death():
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
