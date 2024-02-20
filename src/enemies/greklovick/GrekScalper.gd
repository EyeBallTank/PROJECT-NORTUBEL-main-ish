extends KinematicBody2D

export var gravity: = 33600

var direction = Vector2.RIGHT
var velocity = Vector2.ZERO
onready var eyes = $Eyes
onready var animationplayer = $AnimationPlayer
onready var sprites = $Sprites


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
			if see_to_attack():
				state = JUMP
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

		EATING:
			sprites.play("eating")

		DEAD:
			sprites.play("dead")

func see_to_attack():
	if not eyes.is_colliding(): return false
	var collider = eyes.get_collider()
	if not collider.is_in_group("protagonists"): return false
	return true
