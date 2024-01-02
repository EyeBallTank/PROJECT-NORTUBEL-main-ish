extends KinematicBody2D

#NOTE TO SELF: FIND A SOLUTION THAT DOESN'T USE YIELD STATEMENTS BUT STILL WORKS THE SAME

export var gravity: = 33600

var direction = Vector2.RIGHT
var velocity = Vector2.ZERO
onready var eyes = $Eyes
onready var dizzytimer = $DizzyTimer
onready var impacttimer = $ImpactTimer
onready var animationplayer = $AnimationPlayer
onready var sprites = $Sprites
var impact_timer_starting
var dizzy_timer_starting

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
			sprites.play("moving")
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

			
			sprites.play("running")
			velocity = direction * 560
			velocity.y += gravity * delta
			move_and_slide(velocity, Vector2.UP)
			gravity = 33600
			var found_wall = is_on_wall()
			if found_wall:
				direction *= -1
				scale.x = -scale.x
				state = DIZZYJUMP
				impact_timer_starting = true # new lin to set the Bool
				
		DIZZYJUMP:
			sprites.play("dizzy")

			velocity = direction * 100
			velocity.y += gravity * delta
			move_and_slide(velocity, Vector2.UP)
			gravity = 33600
			if impact_timer_starting:
				impacttimer.start(1)
				impact_timer_starting = false

#			impacttimer.start(1)
			if impacttimer.time_left == 0:
				state = DIZZYIDLE
				dizzy_timer_starting = true
				
#			yield(get_tree().create_timer(1), "timeout")
#			state = DIZZYIDLE


		DIZZYIDLE:
			sprites.play("fall")
			velocity.x = 0
			velocity.y += gravity * delta
			move_and_slide(velocity, Vector2.UP)
			gravity = 33600
#			yield(get_tree().create_timer(2), "timeout")
#			state = MOVING

			if dizzy_timer_starting:
				dizzytimer.start(2)
				dizzy_timer_starting = false


#			dizzytimer.start(2)
			if dizzytimer.time_left == 0:
				state = MOVING

		DEAD:
			sprites.play("dead")
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
