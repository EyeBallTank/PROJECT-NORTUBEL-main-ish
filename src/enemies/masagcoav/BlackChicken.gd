extends KinematicBody2D

export var gravity: = 33600

var direction = Vector2.RIGHT
var velocity = Vector2.ZERO
onready var eyes = $Eyes
onready var dizzytimer = $DizzyTimer
onready var impacttimer = $ImpactTimer

enum {
	MOVING,
	RUNNING,
	DIZZY,
	DEAD
}

var state = MOVING

func _ready():
	pass

func _physics_process(delta):
	match state:
		MOVING:
			if see_to_attack():
				state = RUNNING

			var found_wall = is_on_wall()
			if found_wall:
				direction *= -1
				scale.x = -scale.x
			velocity = direction * 160
			velocity.y += gravity * delta
			move_and_slide(velocity, Vector2.UP)
			gravity = 37600
		RUNNING:
			velocity = direction * 560
			velocity.y += gravity * delta
			move_and_slide(velocity, Vector2.UP)
			gravity = 37600
			var found_wall = is_on_wall()
			if found_wall:
				direction *= -1
				scale.x = -scale.x
				state = DIZZY
				
		DIZZY:
			impacttimer.start(1)
			velocity = direction * 50
			velocity.y += gravity * delta
			move_and_slide(velocity, Vector2.UP)
			gravity = 37600

			if impacttimer.time_left == 0:
				velocity.x = 0
				dizzytimer.start(2)
				if dizzytimer.time_left == 0:
					state = MOVING

func see_to_attack():
	if not eyes.is_colliding(): return false
	var collider = eyes.get_collider()
	if not collider.is_in_group("protagonists"): return false
#	if not collider is StellaMain: return false
#	if not collider is Companion: return false
	return true

func die():
	queue_free()

