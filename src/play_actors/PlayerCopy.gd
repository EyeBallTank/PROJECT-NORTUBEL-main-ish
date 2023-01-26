extends KinematicBody2D

const FLOOR_NORMAL: = Vector2.UP

export var speed: = Vector2(300.0, 1000.0)
export var gravity: = 3000.0
export var jump_buffer_time : int  = 15

var velocity: = Vector2.ZERO
var jump_buffer_counter : int = 0


#The following comments are not my own, if that isn't clear enough

#THESE ARE PREPERATIONS FOR FUTURE PLAYER SATES
enum {
	MAINSTATE,
#	CLIMB,
	PUSH
#	SWIM,
#	SWING,
#	KICK,
#	KNIFE
}

var state = MAINSTATE

var WALK_FORCE = 1600
var WALK_MAX_SPEED = 700
var STOP_FORCE = 900
var JUMP_SPEED = 1500

func _physics_process(delta):
	# Still using frankensteined code to do this
	match state:
		PUSH:
			WALK_MAX_SPEED = 150
			if Input.get_action_strength("right"):
				velocity.x = WALK_MAX_SPEED
				$Sprite.flip_h = false
			elif Input.get_action_strength("left"):
				velocity.x = -WALK_MAX_SPEED
				$Sprite.flip_h = true
			else:
				velocity.x = move_toward(velocity.x, 0, STOP_FORCE * delta)
			velocity.y += gravity * delta

			velocity = move_and_slide_with_snap(velocity, Vector2.DOWN, Vector2.UP)

			if is_on_floor():
				if Input.is_action_just_pressed("jumpup"):
					state = MAINSTATE
					velocity.y = -JUMP_SPEED
		
		MAINSTATE:
			WALK_MAX_SPEED = 700
			if Input.get_action_strength("right"):
				velocity.x = WALK_MAX_SPEED
				$Sprite.flip_h = false
			elif Input.get_action_strength("left"):
				velocity.x = -WALK_MAX_SPEED
				$Sprite.flip_h = true
			else:
				velocity.x = move_toward(velocity.x, 0, STOP_FORCE * delta)
	
	#if velocity.x < WALK_FORCE * 0.1:
		# The velocity, slowed down a bit, and then reassigned.
	#	velocity.x = move_toward(velocity.x, 0, STOP_FORCE * delta)
	#else:
	#	velocity.x += walk * delta
	# Clamp to the maximum horizontal movement speed.
	#velocity.x = clamp(velocity.x, -WALK_MAX_SPEED, WALK_MAX_SPEED)

	# Vertical movement code. Apply gravity.
			velocity.y += gravity * delta

	# Move based on the velocity and snap to the ground.
			velocity = move_and_slide_with_snap(velocity, Vector2.DOWN, Vector2.UP)

	# Check for jumping. is_on_floor() must be called after movement code.
			if is_on_floor() and Input.is_action_just_pressed("jumpup"):
				velocity.y = -JUMP_SPEED
			#This is where i copy code from a video/page by Dicode1q
			if Input.is_action_just_pressed("jumpup"):
				jump_buffer_counter = jump_buffer_time
			
			if Input.is_action_just_released("jumpup"):
				if velocity.y < 0:
					velocity.y += 500
				
			if jump_buffer_counter > 0:
				jump_buffer_counter -= 1
			
			if jump_buffer_counter > 0 and is_on_floor():
				velocity.y = -JUMP_SPEED
				jump_buffer_counter = 0
		
	for index in get_slide_count():
		var collision = get_slide_collision(index)
		if collision.collider.is_in_group("pushable"):
			state = PUSH
		else:
			state = MAINSTATE

# MIGHT NEED A STATE MACHINE FOR THIS
# AT LEAST I FIGURED OUT A SPEED NERD "POWER DOWN" I GUESS
