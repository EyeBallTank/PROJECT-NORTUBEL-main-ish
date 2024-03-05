extends KinematicBody2D

export var gravity: = 3700

var direction = Vector2.RIGHT
var velocity = Vector2.ZERO

onready var sprite = $AnimatedSprite
onready var animation = $AnimationPlayer
onready var raycast = $RayCast2D
onready var timer = $Timer

enum {
	MOVING,
	SUMMON,
	DEAD
}

var state = MOVING

func _ready():
	animation.play("RESET")
