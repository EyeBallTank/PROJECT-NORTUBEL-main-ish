extends KinematicBody2D
class_name UulgaMain

#CURRENT ISSUE: HER JUMPGOESUP ANIMATION ONLY ANIMATES DURING STANDSTILL, BECAUSE IN OTHER STATES,
#THE ANIMATION IS STUCK IN THE FIRST FRAME


enum {
	FOLLOWME,
	STANDSTILL,
	RUNAWAY,
	ATTACKFROMFOLLOW,
	ATTACKFROMRUN,
	ATTACKFROMIDLE
}

var state = STANDSTILL

var WALK_FORCE = 1600
var WALK_MAX_SPEED = 400
var STOP_FORCE = 450
var JUMP_SPEED = 1800

export var speed: = Vector2(300.0, 1000.0)
export var gravity: = 1450.0
onready var animatedsprite = $AnimatedSprite
onready var enemycheck = $RayCast2D

onready var meleespawn = $RayCast2D/meleespawn

onready var uulgastateteller = $CanvasLayer/UulgaStateTeller
onready var audioplayer = $AudioStreamPlayer
var was_on_floor = true

onready var animationplayer = $AnimationPlayer
onready var timer = $Timer

var vel: = Vector2.ZERO
var direction: = Vector2.ZERO
onready var Player = get_parent().get_node("Player")

const MeleeAttack = preload("res://src/play_actors/uulga/UulgaMeleeTest.tscn")


func _ready():
	Signals.connect("player_died", self, "_on_Player_Died")

func _on_Player_Died():
	if state == FOLLOWME:
		state = STANDSTILL
	if state == RUNAWAY:
		state = STANDSTILL
	if state == ATTACKFROMFOLLOW:
		state = STANDSTILL
	if state == ATTACKFROMRUN:
		state = STANDSTILL
	if state == ATTACKFROMIDLE:
		state = STANDSTILL

func _physics_process(delta):
	if animatedsprite.flip_h == false:
		enemycheck.scale.x = 1
	elif animatedsprite.flip_h == true:
		enemycheck.scale.x = -1
#I GUESS HER RAYCAST FLIPPING WORKS NOW?

	match state:
		FOLLOWME:
			if see_to_attack():
				state = ATTACKFROMFOLLOW
			uulgastateteller.play("followstate")

			if Player.global_position.x < global_position.x - 10:
				vel.x = -WALK_MAX_SPEED
				direction.x = -1
				
			elif Player.global_position.x > global_position.x + 10:
				vel.x = WALK_MAX_SPEED
				direction.x = 1
				
			else:
				vel.x = 0
				direction.x = 0
			vel.x = direction.x * 400

			if direction.x == 1 and is_on_floor():
				animatedsprite.animation = "Running"
				animatedsprite.flip_h = false
#				uulgahitbox.position = Vector2(212, -9.5)
			elif direction.x == -1 and is_on_floor():
				animatedsprite.animation = "Running"
				animatedsprite.flip_h = true
#				uulgahitbox.position = Vector2(-213, -9.5)
			else:
				animatedsprite.animation = "Idle"

			vel.y += gravity * delta
			gravity = 1450.0
			vel = move_and_slide_with_snap(vel, Vector2.DOWN, Vector2.UP)

			if is_on_floor() and Input.is_action_just_pressed("stellajump"):
				vel.y = -JUMP_SPEED
				if vel.y < 0:
					vel.y += 500

			if vel.y < 0 and not is_on_floor():
				animatedsprite.rotation_degrees += 8
				animatedsprite.animation = "nevermind"
				if direction.x == 1:
					animatedsprite.flip_h = false
				elif direction.x == -1:
					animatedsprite.flip_h = true
			elif vel.y > 0 and not is_on_floor():
				animatedsprite.animation = "Jumpgoesdown"
				animatedsprite.rotation_degrees = 0
				if direction.x == 1:
					animatedsprite.flip_h = false
				elif direction.x == -1:
					animatedsprite.flip_h = true

			if is_on_floor() and not was_on_floor:
				audioplayer.play()
			was_on_floor = is_on_floor()

			if Input.is_action_pressed("stellacommand") and Input.is_action_just_pressed("left"):
				state = RUNAWAY
			if Input.is_action_pressed("stellacommand") and Input.is_action_just_pressed("down"):
				state = STANDSTILL

			if Input.is_action_just_pressed("basicstellarun"):
				state = RUNAWAY
			if Input.is_action_just_pressed("basicstellastop"):
				state = STANDSTILL

		STANDSTILL:
			if see_to_attack():
				state = ATTACKFROMIDLE
			uulgastateteller.play("stopstate")
			vel.x = 0
			direction.x = 0
			vel.x = direction.x * 0

			if is_on_floor() and Input.is_action_just_pressed("stellajump"):
				vel.y = -JUMP_SPEED
				if vel.y < 0:
					vel.y += 500

			vel.y += gravity * delta
			gravity = 1450.0
			vel = move_and_slide_with_snap(vel, Vector2.DOWN, Vector2.UP)

			if is_on_floor() and not was_on_floor:
				audioplayer.play()
			was_on_floor = is_on_floor()

			if vel.y < 0 and not is_on_floor():
				animatedsprite.rotation_degrees += 8
				animatedsprite.animation = "nevermind"
				if direction.x == 1:
					animatedsprite.flip_h = false
				elif direction.x == -1:
					animatedsprite.flip_h = true
			elif vel.y > 0 and not is_on_floor():
				animatedsprite.animation = "Jumpgoesdown"
				animatedsprite.rotation_degrees = 0
				if direction.x == 1:
					animatedsprite.flip_h = false
				elif direction.x == -1:
					animatedsprite.flip_h = true

			if is_on_floor():
				animatedsprite.animation = "Idle"

			if Input.is_action_pressed("stellacommand") and Input.is_action_just_pressed("right"):
				state = FOLLOWME
			if Input.is_action_pressed("stellacommand") and Input.is_action_just_pressed("left"):
				state = RUNAWAY

			if Input.is_action_just_pressed("basicstellarun"):
				state = RUNAWAY
			if Input.is_action_just_pressed("basicstellafollow"):
				state = FOLLOWME

		RUNAWAY:
			if see_to_attack():
				state = ATTACKFROMRUN
			uulgastateteller.play("runstate")

			if Player.global_position.x < global_position.x - 10:
				vel.x = WALK_MAX_SPEED
				direction.x = 1
			elif Player.global_position.x > global_position.x + 10:
				vel.x = -WALK_MAX_SPEED
				direction.x = -1
			else:
				vel.x = 0
				direction.x = 0
			vel.x = direction.x * 400

			if direction.x == 1 and is_on_floor():
				animatedsprite.animation = "Running"
				animatedsprite.flip_h = false
			elif direction.x == -1 and is_on_floor():
				animatedsprite.animation = "Running"
				animatedsprite.flip_h = true
			else:
				animatedsprite.animation = "Idle"

			vel.y += gravity * delta
			gravity = 1450.0
			vel = move_and_slide_with_snap(vel, Vector2.DOWN, Vector2.UP)

			if is_on_floor() and Input.is_action_just_pressed("stellajump"):
				vel.y = -JUMP_SPEED
				if vel.y < 0:
					vel.y += 500

			if vel.y < 0 and not is_on_floor():

				animatedsprite.animation = "nevermind"
				if direction.x == 1:
					animatedsprite.flip_h = false
					animatedsprite.rotation_degrees += 8
				elif direction.x == -1:
					animatedsprite.flip_h = true
					animatedsprite.rotation_degrees -= 8
			elif vel.y > 0 and not is_on_floor():
				animatedsprite.animation = "Jumpgoesdown"
				animatedsprite.rotation_degrees = 0
				if direction.x == 1:
					animatedsprite.flip_h = false
				elif direction.x == -1:
					animatedsprite.flip_h = true

			if is_on_floor() and not was_on_floor:
				audioplayer.play()
			was_on_floor = is_on_floor()

			if Input.is_action_pressed("stellacommand") and Input.is_action_just_pressed("right"):
				state = FOLLOWME
			if Input.is_action_pressed("stellacommand") and Input.is_action_just_pressed("down"):
				state = STANDSTILL

			if Input.is_action_just_pressed("basicstellafollow"):
				state = FOLLOWME
			if Input.is_action_just_pressed("basicstellastop"):
				state = STANDSTILL

		ATTACKFROMFOLLOW:
			animationplayer.play("uulga attack")

			vel.y += gravity * delta
			gravity = 1450.0
			vel = move_and_slide_with_snap(vel, Vector2.DOWN, Vector2.UP)

			if is_on_floor() and not was_on_floor:
				audioplayer.play()
			was_on_floor = is_on_floor()

			vel.x = 0
			direction.x = 0
			vel.x = direction.x * 0

		ATTACKFROMRUN:
			animationplayer.play("uulga attack run")

			vel.y += gravity * delta
			gravity = 1450.0
			vel = move_and_slide_with_snap(vel, Vector2.DOWN, Vector2.UP)

			if is_on_floor() and not was_on_floor:
				audioplayer.play()
			was_on_floor = is_on_floor()

			vel.x = 0
			direction.x = 0
			vel.x = direction.x * 0

		ATTACKFROMIDLE:
			animationplayer.play("uulga attack idle")

			vel.y += gravity * delta
			gravity = 1450.0
			vel = move_and_slide_with_snap(vel, Vector2.DOWN, Vector2.UP)

			if is_on_floor() and not was_on_floor:
				audioplayer.play()
			was_on_floor = is_on_floor()

			vel.x = 0
			direction.x = 0
			vel.x = direction.x * 0

func see_to_attack():
	if not enemycheck.is_colliding(): return false
	var collider = enemycheck.get_collider()
	if not collider.is_in_group("enemies"): return false
#	if not collider is StellaMain: return false
#	if not collider is Companion: return false
	return true

func actual_attack():
	var elec_hurt = MeleeAttack.instance()
	get_tree().get_root().add_child(elec_hurt)
	elec_hurt.global_position = meleespawn.global_position
	timer.start(0.5)

func return_to_move_follow():
	state = FOLLOWME

func return_to_move_run():
	state = RUNAWAY

func return_to_move_idle():
	state = STANDSTILL
