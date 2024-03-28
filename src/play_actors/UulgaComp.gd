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
	pass

func return_to_move():
	if state == ATTACKFROMFOLLOW:
		FOLLOWME
	elif state == ATTACKFROMRUN:
		RUNAWAY
	elif state == ATTACKFROMIDLE:
		STANDSTILL
