extends KinematicBody2D

onready var animation = $AnimationPlayer
onready var sprite = $AnimatedSprite
onready var raycast = $RayCast2D
onready var timer = $Timer

var direction = Vector2.RIGHT
var velocity = Vector2.ZERO

enum {
	FLOATING,
	SLAM,
	DEAD
}

var state = FLOATING


func _ready():
	sprite.play("handnormal")

func _physics_process(delta):

	match state:
		FLOATING:
			sprite.play("handnormal")
			if see_to_punch():
				state = SLAM
		SLAM:
			pass
		DEAD:
			pass

func see_to_punch():
	if not raycast.is_colliding(): return false
	var collider = raycast.get_collider()
	if not collider.is_in_group("protagonists"): return false
	return true
