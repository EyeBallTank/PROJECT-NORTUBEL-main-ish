extends KinematicBody2D

const FLOOR_NORMAL: = Vector2.UP

export var speed: = Vector2(300.0, 1000.0)
export var gravity: = 29600

var velocity: = Vector2.ZERO

onready var Player = get_parent().get_node("Player")

var direction = Vector2.ZERO
var JUMP_SPEED = 1500

var grav = 1800
var max_grav = 3000

#func get_direction():
func _physics_process(delta):
	velocity.y += grav * delta;
	if velocity.y > max_grav:
		velocity.y = max_grav

	if Player.global_position.x < global_position.x - 10:
		direction.x = -1
	elif Player.global_position.x > global_position.x + 10:
		direction.x = 1
	else:
		direction.x = 0
	velocity = direction * 490
	velocity.y += gravity * delta
	move_and_slide_with_snap(velocity, Vector2.UP)

	var new_vel = velocity
	
	if !is_on_floor():
		new_vel.y += gravity * delta
	if is_on_floor():
		new_vel.x - direction.x * speed.x
		
	if Player.global_position.y < global_position.y - 10:
		if is_on_floor() and velocity.y < 0:
			velocity.y += 500

	elif direction.x == 0:
		new_vel.x = 0

	return new_vel
