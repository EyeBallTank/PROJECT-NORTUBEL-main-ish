extends KinematicBody2D

export var gravity: = 33600

var direction = Vector2.RIGHT
var velocity = Vector2.ZERO
var JUMP_SPEED = 1450

onready var eyes = $Eyes
onready var animationplayer = $AnimationPlayer
onready var sprites = $Sprites
onready var Player = get_parent().get_node("Player")

func _ready():
	pass 

enum {
	MOVING,
	JUMP,
	EATING,
	DEAD
}

var state = MOVING

func _physics_process(delta):

	match state:
		MOVING:
			sprites.play("moving")
			if see_to_attack() and is_on_floor():
				state = JUMP
			elif see_to_attack() and not is_on_floor():
				pass
			var found_wall = is_on_wall()
			if found_wall:
				direction *= -1
				scale.x = -scale.x
			velocity = direction * 140
			velocity.y += gravity * delta
			move_and_slide(velocity, Vector2.UP)
			gravity = 33600

		JUMP:
			sprites.play("jump")
			velocity = direction * 560
			velocity.y += gravity * delta
			move_and_slide(velocity, Vector2.UP)
			gravity = 33600
			var found_wall = is_on_wall()
			if found_wall:
				do_a_jump()


		EATING:
			sprites.play("eating")
			global_position = Player.global_position

		DEAD:
			sprites.play("dead")


func do_a_jump():
	velocity.y = -JUMP_SPEED
	if velocity.y < 0:
		velocity.y += 500

func see_to_attack():
	if not eyes.is_colliding(): return false
	var collider = eyes.get_collider()
	if not collider.is_in_group("protagonists"): return false
	return true
