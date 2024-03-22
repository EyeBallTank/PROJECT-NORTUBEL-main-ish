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

func _ready():
	pass
