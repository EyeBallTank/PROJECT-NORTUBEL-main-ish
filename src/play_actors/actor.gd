extends KinematicBody2D
class_name actor

# This code is copied from the platformer tutorial by GDQuest

const FLOOR_NORMAL: = Vector2.UP


export var speed: = Vector2(300.0, 1000.0)
export var gravity: = 3000.0

var velocity: = Vector2.ZERO
