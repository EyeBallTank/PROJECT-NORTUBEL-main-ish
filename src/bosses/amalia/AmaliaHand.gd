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
	animation.play("RESET")
	sprite.play("handnormal")

func _physics_process(delta):

	match state:
		FLOATING:
			sprite.play("handnormal")
			if see_to_punch():
				state = SLAM
			velocity = direction * 290
			move_and_slide(velocity, Vector2.UP)
			var found_wall = is_on_wall()
			if found_wall:
				direction *= -1
		SLAM:
			animation.play("slamming")
			velocity = 0
			timer.start(5)
			if timer.time_left == 0:
				state = FLOATING
		DEAD:
			animation.play("dying")

func see_to_punch():
	if not raycast.is_colliding(): return false
	var collider = raycast.get_collider()
	if not collider.is_in_group("protagonists"): return false
	return true

func return_to_move():
	state = FLOATING

func die():
	queue_free()


func _on_Hurtbox_area_entered(area):
	if area.name == "PlayerMelee":
		state = DEAD
