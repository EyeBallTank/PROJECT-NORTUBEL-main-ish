extends Node2D

onready var animation = $AnimationPlayer
onready var mainsprite = $MainBox/AnimatedSprite
onready var raycast = $MainBox/RayCast2D
onready var timer = $Timer
onready var mainbox = $MainBox


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
			if see_to_punch():
				state = PUNCH

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
