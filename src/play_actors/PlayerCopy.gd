extends KinematicBody2D

const FLOOR_NORMAL: = Vector2.UP

var BALL_VELOCITY = 1500.0
const Ball = preload("res://src/level_objects/SoccerBall.tscn")

export var speed: = Vector2(300.0, 1000.0)
export var gravity: = 3000.0
export var jump_buffer_time : int  = 15
export var health : int = 100
#export var oxygen : int = 100

var velocity: = Vector2.ZERO
var jump_buffer_counter : int = 0

#The following comments are not my own, if that isn't clear enough

#THESE ARE PREPERATIONS FOR FUTURE PLAYER SATES
enum {
	MAINSTATE,
	CLIMB,
	SWIM,
	ROPE,
	KICKBALL,
#	KNIFE
#	DEATH
	SLOW
	ICE
}

var state = MAINSTATE
var hasyellowkey = false
var hasbluekey = false
var hasredkey = false
var hasfishhook = false
var hasball = true
var attachedtorope = null
#var is_pushing = false

var WALK_FORCE = 1600
var WALK_MAX_SPEED = 700
var PUSH_SPEED = 150
var STOP_FORCE = 450
var JUMP_SPEED = 1500

onready var healthBar = $HealthbarPlayer
onready var ladderCheck = $LadderCheck
onready var swimCheck = $SwimCheck
onready var iceCheck = $IceCheck
onready var ropeCheck = $RopeCheck
onready var hurtbox = $Hurtbox
onready var playerhitbox = $PlayerHitbox
onready var playerhitboxcollision = $PlayerHitbox/HitboxPlayer
#onready var pushCheck = $PushCheckers

func _ready():
	playerhitboxcollision.disabled = true
	healthBar.max_value = health

func _physics_process(delta):
	

	healthBar.value = health
	if health <= 0:
		die()

	# Still using frankensteined code to do this		
	match state:
		SLOW:
			pushcheck()
			if Input.is_action_just_pressed("attack"):
				knife_attack()

			if Input.is_action_just_pressed("kickball"):
				if hasball == true:
					state = KICKBALL
				else:
					pass

			if Input.get_action_strength("right"):
				velocity.x = PUSH_SPEED
				$Sprite.flip_h = false
			elif Input.get_action_strength("left"):
				velocity.x = -PUSH_SPEED
				$Sprite.flip_h = true
			else:
				velocity.x = 0

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
		ICE:
			pushcheck()
			if Input.is_action_just_pressed("attack"):
				knife_attack()

			if Input.is_action_just_pressed("kickball"):
				if hasball == true:
					state = KICKBALL
				else:
					pass

			var walk = WALK_FORCE * (Input.get_action_strength("right") - Input.get_action_strength("left"))
			WALK_MAX_SPEED = 850
			if Input.get_action_strength("right"):
				$Sprite.flip_h = false
				playerhitboxcollision.position = Vector2(65, 2)
			elif Input.get_action_strength("left"):
				$Sprite.flip_h = true
				playerhitboxcollision.position = Vector2(-67, 2)
			if abs(walk) < WALK_FORCE * 0.1:
				velocity.x = move_toward(velocity.x, 0, STOP_FORCE * delta)
			else:
				velocity.x += walk * delta
			velocity.x = clamp(velocity.x, -WALK_MAX_SPEED, WALK_MAX_SPEED)
			
			velocity.y += gravity * delta
			velocity = move_and_slide_with_snap(velocity, Vector2.DOWN, Vector2.UP)

			if is_on_floor() and Input.is_action_just_pressed("jumpup"):
				velocity.y = -JUMP_SPEED

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
				if Input.get_action_strength("jumpup"):
					state = CLIMB
			if is_on_water():
				state = SWIM
			if not is_on_ice():
				if is_on_floor():
					state = MAINSTATE
				else:
					pass

		MAINSTATE:
			pushcheck()
			if Input.is_action_just_pressed("attack"):
				knife_attack()

			if Input.is_action_just_pressed("kickball"):
				if hasball == true:
					state = KICKBALL
				else:
					pass

			WALK_MAX_SPEED = 700
			if Input.get_action_strength("right"):
				velocity.x = WALK_MAX_SPEED
				$Sprite.flip_h = false
				playerhitboxcollision.position = Vector2(65, 2)
			elif Input.get_action_strength("left"):
				velocity.x = -WALK_MAX_SPEED
				$Sprite.flip_h = true
				playerhitboxcollision.position = Vector2(-67, 2)
			else:
#				velocity.x = move_toward(velocity.x, 0, STOP_FORCE * delta)
				velocity.x = 0

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
				if Input.get_action_strength("jumpup"):
					state = CLIMB
			if is_on_rope():
				if Input.is_action_just_pressed("jumpup"):
					state = ROPE

			if is_on_water():
				state = SWIM
			if is_on_ice():
				state = ICE

		CLIMB:
			PUSH_SPEED = 350
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
		ROPE:
#			global_position = DetectableRope.global_position
			if not is_on_rope():
				state = MAINSTATE
			if Input.is_action_just_pressed("jumpup"):
				velocity.y = -JUMP_SPEED
				state = MAINSTATE
		SWIM:
			PUSH_SPEED = 350
			if Input.get_action_strength("right"):
				velocity.x = PUSH_SPEED
				velocity.y = 0
				$Sprite.flip_h = false
			elif Input.get_action_strength("left"):
				velocity.x = -PUSH_SPEED
				velocity.y = 0
				$Sprite.flip_h = true
			elif Input.get_action_strength("jumpup"):
				velocity.y = -PUSH_SPEED
			elif Input.get_action_strength("down"):
				velocity.y = PUSH_SPEED
			else:
				velocity.x = 0
				velocity.y = 100
			velocity = move_and_slide_with_snap(velocity, Vector2.DOWN, Vector2.UP)
			
			if not is_on_water():
				state = MAINSTATE
		KICKBALL:
			velocity.x = 0
			velocity.y += gravity * delta
			velocity = move_and_slide_with_snap(velocity, Vector2.DOWN, Vector2.UP)
			
			var direction = Input.get_axis("left", "right")
			if Input.is_action_just_pressed("right"):
				if hasball == true:
					$Sprite.flip_h = false
					playerhitboxcollision.position = Vector2(65, 2)
					direction = 1
					var soccerball = Ball.instance()
					soccerball.global_position = playerhitboxcollision.global_position
					soccerball.linear_velocity = Vector2(direction * BALL_VELOCITY, 0)
					get_tree().get_root().add_child(soccerball)
					hasball = false
					yield(get_tree().create_timer(0.5), "timeout")
					state = MAINSTATE
				else:
					pass
			elif Input.is_action_just_pressed("left"):
				if hasball == true:
					$Sprite.flip_h = true
					playerhitboxcollision.position = Vector2(-67, 2)
					direction = -1
					var soccerball = Ball.instance()
					soccerball.global_position = playerhitboxcollision.global_position
					soccerball.linear_velocity = Vector2(direction * BALL_VELOCITY, 0)
					get_tree().get_root().add_child(soccerball)
					hasball = false
					yield(get_tree().create_timer(0.5), "timeout")
					state = MAINSTATE
				else:
					pass
			if Input.get_action_strength("down"):
				state = MAINSTATE

# MIGHT NEED A STATE MACHINE FOR THIS
# AT LEAST I FIGURED OUT A SPEED NERF "POWER DOWN" I GUESS

func get_hurt():
	$AnimationPlayer.play("playerhurt")
	health -= 10
	velocity.y -= 500

func die():
	get_tree().reload_current_scene()

#func shoot():
#	var direction = Input.get_axis("left", "right")
#	var soccerball = Ball.instance()
#	soccerball.global_position = playerhitboxcollision.global_position
#	soccerball.linear_velocity = Vector2(direction * BALL_VELOCITY, 0)
#	get_tree().get_root().add_child(soccerball)
#	if Input.get_action_strength("right"):
#		direction = 1
#	elif Input.get_action_strength("left"):
#		direction = -1

func knife_attack():
	playerhitboxcollision.disabled = true
	yield(get_tree().create_timer(0.1), "timeout")
	playerhitboxcollision.disabled = false
	yield(get_tree().create_timer(0.3), "timeout")
	playerhitboxcollision.disabled = true

func is_on_ladder():
	if not ladderCheck.is_colliding(): return false
	var collider = ladderCheck.get_collider()
	if not collider is Ladder: return false
	return true

func is_on_water():
	if not swimCheck.is_colliding(): return false
	var collider = swimCheck.get_collider()
	if not collider is Water: return false
	return true

func is_on_ice():
	if not iceCheck.is_colliding(): return false
	var collider = iceCheck.get_collider()
	if not collider is IceFloor: return false
	return true

func is_on_rope():
	if not ropeCheck.is_colliding(): return false
	var collider = ropeCheck.get_collider()
	if not collider is DetectableRope: return false
	return true
#	if collider.is_in_group("grabbablerope"):
#		attachedtorope = DetectableRope
#

func _on_Hurtbox_area_entered(area):
	if area.name == "EnemyHitbox":
		get_hurt()

func pushcheck():
	for index in get_slide_count():
		var collision = get_slide_collision(index)
		if collision.collider is PushableCopy:
			collision.collider.slide(-collision.normal * (WALK_MAX_SPEED / 2) )
		else:
			return false
	return true
