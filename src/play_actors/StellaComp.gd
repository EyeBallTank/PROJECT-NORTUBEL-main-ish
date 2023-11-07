extends KinematicBody2D

enum {
	FOLLOWME,
	STANDSTILL,
	CLIMBIDLE,
	CLIMBMOVE,
	CLIMBRUN,
	PUSHFOLLOW,
	PUSHRUN,
	DEATH,
	HURT,
	RUNAWAY
}

var state = STANDSTILL

export var speed: = Vector2(300.0, 1000.0)
export var gravity: = 3000.0
export var health : int = 100

var vel: = Vector2.ZERO
var direction: = Vector2.ZERO
onready var Player = get_parent().get_node("Player")

onready var healthBar = $CanvasLayer/HealthbarStella
onready var StellaHurtbox = $StellaHurtbox
onready var ladderCheck = $LadderCheck
onready var animatedsprite = $AnimatedSprite
onready var pushdetector = $PushDetector

func _ready():
	pass
