extends KinematicBody2D

export var gravity: = 33600

var direction = Vector2.RIGHT
var velocity = Vector2.ZERO
onready var eyes = $Eyes
onready var dizzytimer = $DizzyTimer
onready var impacttimer = $ImpactTimer
onready var animationplayer = $AnimationPlayer


enum {
	MOVING,
	RUNNING,
	DIZZYJUMP,
	DIZZYIDLE,
	DEAD
}

var state = MOVING

func _ready():
	animationplayer.play("RESET")

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
			gravity = 33600
		RUNNING:
			velocity = direction * 560
			velocity.y += gravity * delta
			move_and_slide(velocity, Vector2.UP)
			gravity = 33600
			var found_wall = is_on_wall()
			if found_wall:
				direction *= -1
				scale.x = -scale.x
				state = DIZZYJUMP
				
		DIZZYJUMP:

			velocity = direction * 100
			velocity.y += gravity * delta
			move_and_slide(velocity, Vector2.UP)
			gravity = 33600

			impacttimer.start(1.0)
			if impacttimer.time_left == 0:
				state = DIZZYIDLE

		DIZZYIDLE:
			velocity.x = 0
			velocity.y += gravity * delta
			move_and_slide(velocity, Vector2.UP)
			gravity = 33600

			dizzytimer.start(2.0)
			if dizzytimer.time_left == 0:
				state = MOVING

		DEAD:
			animationplayer.play("dying")

func see_to_attack():
	if not eyes.is_colliding(): return false
	var collider = eyes.get_collider()
	if not collider.is_in_group("protagonists"): return false
	return true

func die():
	queue_free()


func _on_HurtBoxChicken_area_exited(area):
	if area.name == "PlayerMelee":
		state = DEAD
	if area.name == "EnemyCrusher":
		state = DEAD


func _on_HurtBoxChicken_body_entered(body):
	if body.name == "SoccerBall":
		state = DEAD
