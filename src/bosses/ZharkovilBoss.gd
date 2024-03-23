extends KinematicBody2D

var direction = Vector2.RIGHT
var velocity = Vector2.ZERO

onready var sprite: = $AnimatedSprite
onready var eyes = $Eyes
onready var animation = $AnimationPlayer
onready var timer = $Timer
onready var gunhole = $Gunhole
onready var orbsource = $OrbSource
var phase = 1

var canattack = true
var canmove = true

#const ShotgunBlast = preload("res://src/enemies/greklovick/GrekShotgunPellets.tscn")
#const ShotgunBlastLeft = preload("res://src/enemies/greklovick/GrekShotgunPelletsLeft.tscn")
#const Bomb = preload("res://src/enemies/greklovick/TemporaryExplosion.tscn")

enum {
	MOVING,
	SHOOT,
	HURT,
	DEAD
}

var state = MOVING

func _ready():
	animation.play("RESET")
