extends KinematicBody2D

export var gravity: = 23600

var direction = Vector2.RIGHT
var velocity = Vector2.ZERO

onready var sprite: = $AnimatedSprite
onready var floordetect = $Floordetect
onready var eyes = $Eyes
onready var animation = $AnimationPlayer
onready var timer = $Timer
onready var gunhole = $Position2D
var canattack = false
var canmove = true

const Bullet = preload("res://src/enemies/greklovick/GrekGrenade.tscn")

enum {
	MOVING,
	SHOOT,
	DEAD
}

var state = MOVING

func _ready():
	pass
