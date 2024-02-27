extends KinematicBody2D

export var gravity: = 23600

var direction = Vector2.RIGHT
var velocity = Vector2.ZERO

onready var sprite: = $AnimatedSprite
onready var eyes = $RayCast2D
onready var animation = $AnimationPlayer
onready var timer = $Timer
onready var arrowsource = $ArrowSource

enum {
	MOVING,
	ARROW,
	DEAD
}

var state = MOVING

func _ready():
	pass 
