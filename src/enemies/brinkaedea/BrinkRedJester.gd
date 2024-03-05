extends KinematicBody2D

export var gravity: = 3700

var direction = Vector2.RIGHT
var velocity = Vector2.ZERO
var walk_speed = 90

onready var sprites = $AnimatedSprite
onready var animation = $AnimationPlayer
onready var raycast = $RayCast2D
onready var timer = $Timer

enum {
	MOVING,
	SUMMON,
	DEAD
}

var state = MOVING

func _ready():
	animation.play("RESET")

func _physics_process(delta):



	match state:
		MOVING:
			sprites.play("moving")
			if see_to_attack():
				state = SUMMON
			var found_wall = is_on_wall()
			if found_wall:
				direction *= -1
				scale.x = -scale.x
			velocity.x = direction.x * walk_speed
			velocity.y += gravity * delta
			move_and_slide(velocity, Vector2.UP)


		SUMMON:
			velocity.x = 0
#			animation.play("Shoot")
			timer.start(2)
			if timer.time_left == 0:
				state = MOVING
			velocity.y += gravity * delta
			move_and_slide(velocity, Vector2.UP)

		DEAD:
			pass

func see_to_attack():
	pass

func return_to_move():
	pass

func die():
	queue_free()

