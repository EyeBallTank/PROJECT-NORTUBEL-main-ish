extends Node2D

onready var animation = $AnimationPlayer
onready var mainsprite = $KinematicBody2D/AnimatedSprite



func _ready():
	mainsprite.play("moving")
