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

func _ready():
	animatedsprite.frames = load(rivalskin)
	pass

func _physics_process(delta):
	match state:
		RUN:
			pushcheck()
			
			WALK_MAX_SPEED = 600
			velocity.x = WALK_MAX_SPEED
			pushdetector.position = Vector2(63, 0)
			animatedsprite.animation = "Running"
			animatedsprite.flip_h = false

			velocity.y += gravity * delta
			velocity = move_and_slide_with_snap(velocity, Vector2.DOWN, Vector2.UP)

func pushcheck():
	pass





