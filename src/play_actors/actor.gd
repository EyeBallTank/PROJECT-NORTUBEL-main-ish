extends KinematicBody2D
class_name actor

# This code is copied from the platformer tutorial by GDQuest

const FLOOR_NORMAL: = Vector2.UP
#const PUSH: = 5

export var speed: = Vector2(300.0, 1000.0)
export var gravity: = 3000.0

var velocity: = Vector2.ZERO
#var inertia = move_and_slide(velocity, Vector2.UP, false, 4, PI/4, false)

#func _physics_process(delta):

#	for index in get_slide_count():
#		var collision = get_slide_collision(index)
#		if collision.collider is Pushable:
#			collision.collider.apply_central_impulse(-collision.normal * PUSH)
