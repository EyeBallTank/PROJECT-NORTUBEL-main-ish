extends KinematicBody2D


export var gravity: = 23600

var direction = Vector2.RIGHT
var velocity = Vector2.ZERO

onready var sprite: = $AnimatedSprite
onready var floordetect = $Floordetect
onready var eyes = $Eyes

onready var animation = $AnimationPlayer
onready var timer = $Timer #2 seconds
onready var gunhole = $Position2D
onready var bombspawn = $BombSpawn
var canattack = false
var canmove = true

#const Bullet = preload("res://src/enemies/lahiurn/EygzouhlFire.tscn")
#const FloorFire = preload("res://src/enemies/lahiurn/EygzouhlFloorFire.tscn")
#const BulletLeft = preload("res://src/enemies/lahiurn/EygzouhlFireLeft.tscn")
#

enum {
	MOVING,
	SHOOT,
	DEAD
}

var state = MOVING

func _ready():
	animation.play("RESET")
