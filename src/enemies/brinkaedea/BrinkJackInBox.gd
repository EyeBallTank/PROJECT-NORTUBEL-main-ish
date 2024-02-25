extends KinematicBody2D

onready var animation = $AnimationPlayer
onready var mainsprite = $AnimatedSprite
onready var raycast = $RayCast2D
onready var timer = $Timer


var direction = Vector2.RIGHT
var velocity = Vector2.ZERO
onready var floattimer = $FloatTimer

enum {
	FLOATING,
	PUNCH,
	DEAD
}

var state = FLOATING


func _ready():
	mainsprite.play("moving")
	animation.play("floating")

func _physics_process(delta):

	match state:
		FLOATING:
#			animation.play("floating")
			mainsprite.play("moving")
			if see_to_punch():
				state = PUNCH
			velocity = direction * 290
			move_and_slide(velocity, Vector2.UP)
			var found_wall = is_on_wall()
			if found_wall:
				direction *= -1

		PUNCH:
			animation.play("punch")
			timer.start(2)
			if timer.time_left == 0:
				state = FLOATING


		DEAD:
			animation.play("dying")

func return_to_move():
	state = FLOATING

func die():
	queue_free()

func see_to_punch():
	if not raycast.is_colliding(): return false
	var collider = raycast.get_collider()
	if not collider.is_in_group("protagonists"): return false
	return true



func _on_JackHurtbox_area_entered(area):
	if area.name == "PlayerMelee":
		state = DEAD
