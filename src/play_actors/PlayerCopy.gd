extends KinematicBody2D

const FLOOR_NORMAL: = Vector2.UP

export var speed: = Vector2(300.0, 1000.0)
export var gravity: = 3000.0
export var jump_buffer_time : int  = 15
export var health : int = 100

var velocity: = Vector2.ZERO
var jump_buffer_counter : int = 0

#The following comments are not my own, if that isn't clear enough

#THESE ARE PREPERATIONS FOR FUTURE PLAYER SATES
enum {
	MAINSTATE,
	CLIMB,
	PUSH
#	SWIM,
#	SWING,
#	KICK,
#	KNIFE
#	DEATH
}

var state = MAINSTATE

var WALK_FORCE = 1600
var WALK_MAX_SPEED = 700
var PUSH_SPEED = 150
var STOP_FORCE = 900
var JUMP_SPEED = 1500

onready var healthBar = $HealthbarPlayer
onready var ladderCheck = $LadderCheck

func _ready():
	healthBar.max_value = health

func _physics_process(delta):
	
	
	healthBar.value = health
	if health <= 0:
		die()
#	for index in get_slide_count():
#		var collision = get_slide_collision(index)
#		if collision.collider.is_in_group("enemies"):
#			get_hurt()


	# Still using frankensteined code to do this		
	match state:
		PUSH:
			if Input.get_action_strength("right"):
				velocity.x = PUSH_SPEED
				$Sprite.flip_h = false
			elif Input.get_action_strength("left"):
				velocity.x = -PUSH_SPEED
				$Sprite.flip_h = true
			else:
				velocity.x = move_toward(velocity.x, 0, STOP_FORCE * delta)

			velocity.y += gravity * delta

			velocity = move_and_slide_with_snap(velocity, Vector2.DOWN, Vector2.UP)

			if is_on_floor():
				if Input.is_action_just_pressed("jumpup"):
					state = MAINSTATE
					velocity.y = -JUMP_SPEED
			#Copied code from below to the PUSH state
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
#
		MAINSTATE:
			WALK_MAX_SPEED = 700
			if Input.get_action_strength("right"):
				velocity.x = WALK_MAX_SPEED
				$Sprite.flip_h = false
#				pushdetection.global_rotation = 0
			elif Input.get_action_strength("left"):
				velocity.x = -WALK_MAX_SPEED
				$Sprite.flip_h = true
#				pushdetection.global_rotation = -600
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
			if is_on_ladder():
				state = CLIMB

		CLIMB:
			PUSH_SPEED = 250
			if Input.get_action_strength("right"):
				velocity.x = PUSH_SPEED
			elif Input.get_action_strength("left"):
				velocity.x = -PUSH_SPEED
			elif Input.get_action_strength("jumpup"):
				velocity.y = -PUSH_SPEED
			elif Input.get_action_strength("down"):
				velocity.y = PUSH_SPEED
			else:
				velocity.x = 0
				velocity.y = 0
			velocity = move_and_slide_with_snap(velocity, Vector2.DOWN, Vector2.UP)
			
			if not is_on_ladder():
				state = MAINSTATE
#		SWIM:
		
#	for index in get_slide_count():
#		var collision = get_slide_collision(index)
#		if collision.collider.is_in_group("pushableside"):
#			state = PUSH
#		else:
#			state = MAINSTATE

#	if pushdetection.is_colliding():
#		var object = pushdetection.get_collider()
#		object.move_and_slide(Vector2(pushdetection.scale.x, 0) * speed)
#		state = PUSH
#	else:
#		state = MAINSTATE

#	if get_slide_count() > 0:
#		check_pushable_collision(velocity)
#
#func check_pushable_collision(velocity) -> void:
#	var pushthing : = get_slide_collision(0).collider as PushableCopy
#	if pushthing:
#			pushthing.push(PUSH_SPEED * velocity)

# MIGHT NEED A STATE MACHINE FOR THIS
# AT LEAST I FIGURED OUT A SPEED NERF "POWER DOWN" I GUESS

func get_hurt():
	health -= 10
	velocity.y -= 500
	$AnimationPlayer.play("playerhurt")

func die():
	get_tree().reload_current_scene()

func is_on_ladder():
	if not ladderCheck.is_colliding(): return false
	var collider = ladderCheck.get_collider()
	if not collider is Ladder: return false
	return true
