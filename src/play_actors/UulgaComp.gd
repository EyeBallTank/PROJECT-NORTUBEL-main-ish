extends KinematicBody2D
class_name UulgaMain

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
var WALK_MAX_SPEED = 700
var STOP_FORCE = 450
var JUMP_SPEED = 1500

export var speed: = Vector2(300.0, 1000.0)
export var gravity: = 1450.0
onready var animatedsprite = $AnimatedSprite
onready var enemycheck = $RayCast2D

onready var uulgatateteller = $CanvasLayer/UulgaStateTeller
onready var audioplayer = $AudioStreamPlayer
var was_on_floor = true

var vel: = Vector2.ZERO
var direction: = Vector2.ZERO
onready var Player = get_parent().get_node("Player")

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
	match state:
		FOLLOWME:
			if see_to_attack():
				state = ATTACKFROMFOLLOW
			uulgatateteller.play("followstate")

			if Player.global_position.x < global_position.x - 10:
				vel.x = -WALK_MAX_SPEED
				direction.x = -1
			elif Player.global_position.x > global_position.x + 10:
				vel.x = WALK_MAX_SPEED
				direction.x = 1
			else:
				vel.x = 0
				direction.x = 0
			vel.x = direction.x * 630

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
				animatedsprite.animation = "Jumpgoesup"
				if direction.x == 1:
					animatedsprite.flip_h = false
				elif direction.x == -1:
					animatedsprite.flip_h = true
			elif vel.y > 0 and not is_on_floor():
				animatedsprite.animation = "Jumpgoesdown"
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

func see_to_attack():
	if not enemycheck.is_colliding(): return false
	var collider = enemycheck.get_collider()
	if not collider.is_in_group("enemies"): return false
#	if not collider is StellaMain: return false
#	if not collider is Companion: return false
	return true

func return_to_move():
	if state == ATTACKFROMFOLLOW:
		FOLLOWME
	elif state == ATTACKFROMRUN:
		RUNAWAY
	elif state == ATTACKFROMIDLE:
		STANDSTILL
