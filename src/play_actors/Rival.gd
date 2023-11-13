extends KinematicBody2D
const FLOOR_NORMAL: = Vector2.UP

#Soon
export var rivalskin = "res://assets/sprites/rival sprites/AltOscar.tres"
onready var animatedsprite = $AnimatedSprite

export var speed: = Vector2(300.0, 1000.0)
export var gravity: = 3000.0

var velocity: = Vector2.ZERO

enum {
	RUN,
	CLIMB,
	PUSH,
	IDLE
}

var state = RUN
var was_on_floor = true
var portal_id = 0

var WALK_FORCE = 1600
var WALK_MAX_SPEED = 700
var PUSH_SPEED = 150
var STOP_FORCE = 450
var JUMP_SPEED = 1500

onready var ladderCheck = $LadderCheck
onready var pushdetector = $PushDetector
onready var audioplayer = $AudioStreamPlayer
onready var floordetect = $Floordetect
onready var signdetect = $Signdetect
onready var signdetectclimb = $Signdetectclimb
onready var rundetect = $Rundetect


func _ready():
	animatedsprite.frames = load(rivalskin)
	pass

func _physics_process(delta):
	match state:
		RUN:
			pushcheck()
			detect_jump()
			
			WALK_MAX_SPEED = 600
			velocity.x = WALK_MAX_SPEED
			pushdetector.position = Vector2(63, 0)
			animatedsprite.animation = "Running"
			animatedsprite.flip_h = false

			velocity.y += gravity * delta
			velocity = move_and_slide_with_snap(velocity, Vector2.DOWN, Vector2.UP)

			if velocity.y < 0 and not is_on_floor():
				animatedsprite.animation = "Jumpgoesup"
			elif velocity.y > 0 and not is_on_floor():
				animatedsprite.animation = "Jumpgoesdown"

			if is_on_floor() and not was_on_floor:
				audioplayer.play()
			was_on_floor = is_on_floor()

			if detect_signs():
				state = IDLE

			if detect_climb():
				state = CLIMB

		CLIMB:
			PUSH_SPEED = 350
			velocity.y = -PUSH_SPEED
			velocity.x = 0
			animatedsprite.animation = "Climbing"
			velocity = move_and_slide_with_snap(velocity, Vector2.DOWN, Vector2.UP)

			if detect_signs():
				state = IDLE

			if detect_run():
				state = RUN

		PUSH:
			pass

		IDLE:
			velocity.x = 0
			velocity.y += gravity * delta
			velocity = move_and_slide_with_snap(velocity, Vector2.DOWN, Vector2.UP)
			animatedsprite.animation = "Idle"
			if velocity.y < 0 and not is_on_floor():
				animatedsprite.animation = "Jumpgoesup"
			elif velocity.y > 0 and not is_on_floor():
				animatedsprite.animation = "Jumpgoesdown"

			if is_on_floor() and not was_on_floor:
				audioplayer.play()
			was_on_floor = is_on_floor()

func pushcheck():
	pass

func detect_jump():
	if not floordetect.is_colliding() and is_on_floor():
		velocity.y = -JUMP_SPEED

func detect_signs():
	if not signdetect.is_colliding(): return false
	var collider = signdetect.get_collider()
	if not collider is RivalIdleSign: return false
	return true

func detect_climb():
	if not signdetectclimb.is_colliding(): return false
	var collider = signdetectclimb.get_collider()
	if not collider is RivalClimbSign: return false
	return true

func detect_run():
	if not rundetect.is_colliding(): return false
	var collider = rundetect.get_collider()
	if not collider is RivalRunSign: return false
	return true
