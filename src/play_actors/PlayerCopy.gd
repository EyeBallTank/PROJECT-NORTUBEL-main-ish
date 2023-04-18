extends KinematicBody2D
class_name PlayerMain

const FLOOR_NORMAL: = Vector2.UP

var BALL_VELOCITY = 1500.0
const Ball = preload("res://src/level_objects/SoccerBall.tscn")
const PlayerMelee = preload("res://src/behind_the_scenes/PlayerMelee.tscn")

export var playerskin = "res://assets/sprites/play_actor_sprites/CarrieSprites.tres"

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
	KNIFE,
	DEATH,
	SLOW,
	PUSH,
	ICE,
	SADNESS,
	CALLING
}

var state = MAINSTATE

var hasyellowkey = false
var hasbluekey = false
var hasredkey = false
var hasfishhook = false
var hasball = false

var rope_part = null
var portal_id = 0
#var is_pushing = false
var ouch = false

var WALK_FORCE = 1600
var WALK_MAX_SPEED = 700
var PUSH_SPEED = 150
var STOP_FORCE = 450
var JUMP_SPEED = 1500

onready var camera = $Camera2D
onready var healthBar = $HealthbarPlayer
onready var ladderCheck = $LadderCheck
onready var swimCheck = $SwimCheck
onready var iceCheck = $IceCheck
onready var slowCheck = $SlowCheck
onready var ropeCheck = $RopeCheck
onready var hurtbox = $Hurtbox
onready var hurtboxcollision = $Hurtbox/HurtboxPlayer
onready var playerhitbox = $PlayerHitbox
onready var playerhitboxcollision = $PlayerHitbox/HitboxPlayer
onready var animatedsprite = $AnimatedSprite
onready var pushdetector = $PushDetector


var last_checkpoint: Area2D = null
onready var checkpointTween = $CheckpointTween

func _ready():
	camera.zoom = Vector2(2, 2)
	$FloaterActive.hide()
	animatedsprite.frames = load(playerskin)
	$CollisionShape2D.disabled = false
	playerhitboxcollision.disabled = true
	healthBar.max_value = health
	var playerspawn = get_parent().get_node("playerspawn")
	last_checkpoint = playerspawn

func _physics_process(delta):
	healthBar.value = health
	if health <= 0:
		state = DEATH

	# Still using frankensteined code to do this		
	match state:
		SLOW:
			$CollisionShape2D.shape.extents = Vector2(25.5, 122)
			$CollisionShape2D.position = Vector2(-1.5, -123)
			hurtboxcollision.shape.extents = Vector2(27, 123)
			hurtboxcollision.position = Vector2(-2, -123)
			$RopeCheck/CollisionShape2D.shape.extents = Vector2(6.625, 30.75)
			$RopeCheck/CollisionShape2D.position = Vector2(-0.375, 30)
			$PortalCheck/CollisionShape2D.shape.extents = Vector2(27, 123)
			$PortalCheck/CollisionShape2D.position = Vector2(-2, -123)
			pushcheck()

			if Input.is_action_just_pressed("attack"):
				state = KNIFE

			if Input.is_action_just_pressed("down"):
				if hasball == true:
					state = KICKBALL
				else:
					pass
			WALK_MAX_SPEED = 150
			if Input.get_action_strength("right"):
				velocity.x = WALK_MAX_SPEED
				playerhitboxcollision.position = Vector2(65, 2)
				pushdetector.position = Vector2(63, 0)
			elif Input.get_action_strength("left"):
				velocity.x = -WALK_MAX_SPEED
				playerhitboxcollision.position = Vector2(-67, 2)
				pushdetector.position = Vector2(-59, 0)
			else:
				velocity.x = 0

			if Input.get_action_strength("right") and is_on_floor():
				animatedsprite.animation = "Running"
				animatedsprite.flip_h = false
			elif Input.get_action_strength("left") and is_on_floor():
				animatedsprite.animation = "Running"
				animatedsprite.flip_h = true
			else:
				animatedsprite.animation = "Idle"

			velocity.y += gravity * delta

			velocity = move_and_slide_with_snap(velocity, Vector2.DOWN, Vector2.UP)

			if is_on_floor():
				if Input.is_action_just_pressed("jumpup"):
					state = MAINSTATE
					velocity.y = -JUMP_SPEED

			if velocity.y < 0 and not is_on_floor():
				if ouch == false:
					animatedsprite.animation = "Jumpgoesup"
				elif ouch == true:
					animatedsprite.animation = "Hurt"
				if Input.is_action_just_pressed("right"):
					animatedsprite.flip_h = false
				elif Input.is_action_just_pressed("left"):
					animatedsprite.flip_h = true
			elif velocity.y > 0 and not is_on_floor():
				if ouch == false:
					animatedsprite.animation = "Jumpgoesdown"
				elif ouch == true:
					animatedsprite.animation = "Hurt"
				if Input.is_action_just_pressed("right"):
					animatedsprite.flip_h = false
				elif Input.is_action_just_pressed("left"):
					animatedsprite.flip_h = true

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

			if not is_on_slow():
				if is_on_floor():
					state = MAINSTATE
				else:
					pass
		ICE:
			$CollisionShape2D.shape.extents = Vector2(25.5, 122)
			$CollisionShape2D.position = Vector2(-1.5, -123)
			hurtboxcollision.shape.extents = Vector2(27, 123)
			hurtboxcollision.position = Vector2(-2, -123)
			$RopeCheck/CollisionShape2D.shape.extents = Vector2(6.625, 30.75)
			$RopeCheck/CollisionShape2D.position = Vector2(-0.375, 30)
			$PortalCheck/CollisionShape2D.shape.extents = Vector2(27, 123)
			$PortalCheck/CollisionShape2D.position = Vector2(-2, -123)
			pushcheck()
			if Input.is_action_just_pressed("attack"):
				state = KNIFE

			if Input.is_action_just_pressed("down"):
				if hasball == true:
					state = KICKBALL
				else:
					pass

			var walk = WALK_FORCE * (Input.get_action_strength("right") - Input.get_action_strength("left"))
			WALK_MAX_SPEED = 850
			if Input.get_action_strength("right"):
				animatedsprite.flip_h = false
				playerhitboxcollision.position = Vector2(65, 2)
				pushdetector.position = Vector2(63, 0)
			elif Input.get_action_strength("left"):
				animatedsprite.flip_h = true
				playerhitboxcollision.position = Vector2(-67, 2)
				pushdetector.position = Vector2(-59, 0)
			if abs(walk) < WALK_FORCE * 0.1:
				velocity.x = move_toward(velocity.x, 0, STOP_FORCE * delta)
			else:
				velocity.x += walk * delta
			velocity.x = clamp(velocity.x, -WALK_MAX_SPEED, WALK_MAX_SPEED)

			if Input.get_action_strength("right") and is_on_floor():
				animatedsprite.animation = "Running"
				animatedsprite.flip_h = false
			elif Input.get_action_strength("left") and is_on_floor():
				animatedsprite.animation = "Running"
				animatedsprite.flip_h = true
			else:
				animatedsprite.animation = "Iceslide"

			velocity.y += gravity * delta
			velocity = move_and_slide_with_snap(velocity, Vector2.DOWN, Vector2.UP)

			if is_on_floor() and Input.is_action_just_pressed("jumpup"):
				velocity.y = -JUMP_SPEED

			if velocity.y < 0 and not is_on_floor():
				if ouch == false:
					animatedsprite.animation = "Jumpgoesup"
				elif ouch == true:
					animatedsprite.animation = "Hurt"
				if Input.is_action_just_pressed("right"):
					animatedsprite.flip_h = false
				elif Input.is_action_just_pressed("left"):
					animatedsprite.flip_h = true
			elif velocity.y > 0 and not is_on_floor():
				if ouch == false:
					animatedsprite.animation = "Jumpgoesdown"
				elif ouch == true:
					animatedsprite.animation = "Hurt"
				if Input.is_action_just_pressed("right"):
					animatedsprite.flip_h = false
				elif Input.is_action_just_pressed("left"):
					animatedsprite.flip_h = true

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
			$CollisionShape2D.shape.extents = Vector2(25.5, 122)
			$CollisionShape2D.position = Vector2(-1.5, -123)
			hurtboxcollision.shape.extents = Vector2(27, 123)
			hurtboxcollision.position = Vector2(-2, -123)
			$RopeCheck/CollisionShape2D.shape.extents = Vector2(6.625, 30.75)
			$RopeCheck/CollisionShape2D.position = Vector2(-0.375, 30)
			$PortalCheck/CollisionShape2D.shape.extents = Vector2(27, 123)
			$PortalCheck/CollisionShape2D.position = Vector2(-2, -123)
			pushcheck()

			if Input.is_action_just_pressed("attack"):
				state = KNIFE

			if Input.is_action_just_pressed("down"):
				if hasball == true:
					state = KICKBALL
				else:
					pass

#this worked: if Input.is_action_pressed("down") and Input.is_action_just_pressed("attack"):

			WALK_MAX_SPEED = 700
			if Input.get_action_strength("right"):
				velocity.x = WALK_MAX_SPEED
				playerhitboxcollision.position = Vector2(65, 2)
				pushdetector.position = Vector2(63, 0)
			elif Input.get_action_strength("left"):
				velocity.x = -WALK_MAX_SPEED
				playerhitboxcollision.position = Vector2(-67, 2)
				pushdetector.position = Vector2(-59, 0)
			else:
				velocity.x = 0


			if Input.get_action_strength("right") and is_on_floor():
				animatedsprite.animation = "Running"
				animatedsprite.flip_h = false
			elif Input.get_action_strength("left") and is_on_floor():
				animatedsprite.animation = "Running"
				animatedsprite.flip_h = true
			else:
				animatedsprite.animation = "Idle"

#
#			if Input.get_action_strength("right") and is_on_floor() and is_pushing == true:
#				animatedsprite.animation = "Pushing"
#				animatedsprite.flip_h = false
#			elif Input.get_action_strength("left") and is_on_floor() and is_pushing == true:
#				animatedsprite.animation = "Pushing"
#				animatedsprite.flip_h = true
#			else:
#				animatedsprite.animation = "Idle"

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

			if velocity.y < 0 and not is_on_floor():
				if ouch == false:
					animatedsprite.animation = "Jumpgoesup"
				elif ouch == true:
					animatedsprite.animation = "Hurt"
				if Input.is_action_just_pressed("right"):
					animatedsprite.flip_h = false
				elif Input.is_action_just_pressed("left"):
					animatedsprite.flip_h = true
			elif velocity.y > 0 and not is_on_floor():
				if ouch == false:
					animatedsprite.animation = "Jumpgoesdown"
				elif ouch == true:
					animatedsprite.animation = "Hurt"
				if Input.is_action_just_pressed("right"):
					animatedsprite.flip_h = false
				elif Input.is_action_just_pressed("left"):
					animatedsprite.flip_h = true

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

			if is_on_water():
				state = SWIM
			if is_on_slow():
				state = SLOW
			if is_on_ice():
				state = ICE

		CLIMB:
			$CollisionShape2D.shape.extents = Vector2(25.5, 122)
			$CollisionShape2D.position = Vector2(-1.5, -123)
			hurtboxcollision.shape.extents = Vector2(27, 123)
			hurtboxcollision.position = Vector2(-2, -123)
			$RopeCheck/CollisionShape2D.shape.extents = Vector2(6.625, 30.75)
			$RopeCheck/CollisionShape2D.position = Vector2(-0.375, 30)
			$PortalCheck/CollisionShape2D.shape.extents = Vector2(27, 123)
			$PortalCheck/CollisionShape2D.position = Vector2(-2, -123)
			PUSH_SPEED = 350
			if Input.get_action_strength("right"):
				velocity.x = PUSH_SPEED
				animatedsprite.animation = "Climbing"
				animatedsprite.flip_h = false
				pushdetector.position = Vector2(63, 0)
			elif Input.get_action_strength("left"):
				velocity.x = -PUSH_SPEED
				animatedsprite.animation = "Climbing"
				animatedsprite.flip_h = true
				pushdetector.position = Vector2(-59, 0)
			elif Input.get_action_strength("jumpup"):
				velocity.y = -PUSH_SPEED
				animatedsprite.animation = "Climbing"
			elif Input.get_action_strength("down"):
				velocity.y = PUSH_SPEED
				animatedsprite.animation = "Climbing"
			else:
				velocity.x = 0
				velocity.y = 0
				animatedsprite.animation = "Climbidle"
			velocity = move_and_slide_with_snap(velocity, Vector2.DOWN, Vector2.UP)

			if not is_on_ladder():
				state = MAINSTATE
		ROPE:
			$CollisionShape2D.shape.extents = Vector2(25.5, 122)
			$CollisionShape2D.position = Vector2(-1.5, -123)
			hurtboxcollision.shape.extents = Vector2(27, 123)
			hurtboxcollision.position = Vector2(-2, -123)
			$RopeCheck/CollisionShape2D.shape.extents = Vector2(6.625, 30.75)
			$RopeCheck/CollisionShape2D.position = Vector2(-0.375, 30)
			$PortalCheck/CollisionShape2D.shape.extents = Vector2(27, 123)
			$PortalCheck/CollisionShape2D.position = Vector2(-2, -123)
			animatedsprite.animation = "Ropeattach"
			global_position = rope_part.global_position
			global_rotation = rope_part.global_rotation
			if Input.is_action_just_pressed("jumpup"):
				velocity.y = -JUMP_SPEED
				rope_part = null
				global_rotation = 0
				state = MAINSTATE
		SWIM:
			$CollisionShape2D.shape.extents = Vector2(104.5, 50.5 )
			$CollisionShape2D.position = Vector2(0.5, -161.5)
			hurtboxcollision.shape.extents = Vector2(104.5, 50.5)
			hurtboxcollision.position = Vector2(0.5, -161.5)
			$RopeCheck/CollisionShape2D.shape.extents = Vector2(26.125, 12.625)
			$RopeCheck/CollisionShape2D.position = Vector2(0.125, 20.375)
			$PortalCheck/CollisionShape2D.shape.extents = Vector2(104.5, 50)
			$PortalCheck/CollisionShape2D.position = Vector2(0.5, -162)
			PUSH_SPEED = 350
			if Input.get_action_strength("right"):
				velocity.x = PUSH_SPEED
				velocity.y = 0
				animatedsprite.animation = "Swimming"
				animatedsprite.flip_h = false
				pushdetector.position = Vector2(63, 0)
			elif Input.get_action_strength("left"):
				velocity.x = -PUSH_SPEED
				velocity.y = 0
				animatedsprite.animation = "Swimming"
				animatedsprite.flip_h = true
				pushdetector.position = Vector2(-59, 0)
			elif Input.get_action_strength("jumpup"):
				velocity.y = -PUSH_SPEED
				animatedsprite.animation = "Swimming"
			elif Input.get_action_strength("down"):
				velocity.y = PUSH_SPEED
				animatedsprite.animation = "Swimming"
			else:
				animatedsprite.animation = "Swimidle"
				velocity.x = 0
				velocity.y = 100
			velocity = move_and_slide_with_snap(velocity, Vector2.DOWN, Vector2.UP)
			
			if not is_on_water():
				state = MAINSTATE

		KICKBALL:
			$CollisionShape2D.shape.extents = Vector2(25.5, 122)
			$CollisionShape2D.position = Vector2(-1.5, -123)
			hurtboxcollision.shape.extents = Vector2(27, 123)
			hurtboxcollision.position = Vector2(-2, -123)
			$RopeCheck/CollisionShape2D.shape.extents = Vector2(6.625, 30.75)
			$RopeCheck/CollisionShape2D.position = Vector2(-0.375, 30)
			$PortalCheck/CollisionShape2D.shape.extents = Vector2(27, 123)
			$PortalCheck/CollisionShape2D.position = Vector2(-2, -123)
			if hasball == true:
				animatedsprite.animation = "Abouttokick"
			elif hasball == false:
				animatedsprite.animation = "Kickedtheball"
			velocity.x = 0
			velocity.y += gravity * delta
			velocity = move_and_slide_with_snap(velocity, Vector2.DOWN, Vector2.UP)
			
			var direction = Input.get_axis("left", "right")
			if Input.is_action_just_pressed("right"):
				if hasball == true:
					animatedsprite.flip_h = false
					animatedsprite.animation = "Kickedtheball"
					playerhitboxcollision.position = Vector2(65, 2)
					pushdetector.position = Vector2(63, 0)
					direction = 1
					var soccerball = Ball.instance()
					soccerball.global_position = playerhitboxcollision.global_position
					soccerball.linear_velocity = Vector2(direction * BALL_VELOCITY, 0)
					get_tree().get_root().add_child(soccerball)
					hasball = false
					yield(get_tree().create_timer(0.5), "timeout")
					state = MAINSTATE
					animatedsprite.animation = "Idle"
				else:
					pass
			elif Input.is_action_just_pressed("left"):
				if hasball == true:
					animatedsprite.flip_h = true
					animatedsprite.animation = "Kickedtheball"
					playerhitboxcollision.position = Vector2(-67, 2)
					pushdetector.position = Vector2(-59, 0)
					direction = -1
					var soccerball = Ball.instance()
					soccerball.global_position = playerhitboxcollision.global_position
					soccerball.linear_velocity = Vector2(direction * BALL_VELOCITY, 0)
					get_tree().get_root().add_child(soccerball)
					hasball = false
					yield(get_tree().create_timer(0.5), "timeout")
					state = MAINSTATE
					animatedsprite.animation = "Idle"
				else:
					pass
			if Input.get_action_strength("jumpup"):
				state = MAINSTATE
				animatedsprite.animation = "Idle"

		KNIFE:
			$CollisionShape2D.shape.extents = Vector2(25.5, 122)
			$CollisionShape2D.position = Vector2(-1.5, -123)
			hurtboxcollision.shape.extents = Vector2(27, 123)
			hurtboxcollision.position = Vector2(-2, -123)
			$RopeCheck/CollisionShape2D.shape.extents = Vector2(6.625, 30.75)
			$RopeCheck/CollisionShape2D.position = Vector2(-0.375, 30)
			$PortalCheck/CollisionShape2D.shape.extents = Vector2(27, 123)
			$PortalCheck/CollisionShape2D.position = Vector2(-2, -123)
			velocity.x = 0
			velocity.y += gravity * delta
			velocity = move_and_slide_with_snap(velocity, Vector2.DOWN, Vector2.UP)

			animatedsprite.animation = "Abouttostab"
			playerhitboxcollision.disabled = true
			playerhitbox.set_monitorable(false)
			yield(get_tree().create_timer(0.1), "timeout")
			playerhitboxcollision.disabled = false
			playerhitbox.set_monitorable(true)
			animatedsprite.animation = "Stabtheknife"
			var melee = PlayerMelee.instance()
			melee.global_position = playerhitboxcollision.global_position
			get_tree().get_root().add_child(melee)
			yield(get_tree().create_timer(0.1), "timeout")
			animatedsprite.animation = "Abouttostab"
			playerhitboxcollision.disabled = true
			playerhitbox.set_monitorable(false)
			state = MAINSTATE

		DEATH:
			animatedsprite.animation = "Dead"
			velocity.x = 0
			velocity.y += gravity * delta
			velocity = move_and_slide_with_snap(velocity, Vector2.DOWN, Vector2.UP)
			hurtbox.set_monitoring(false)
#			die()
			yield(get_tree().create_timer(0.4), "timeout")
			$AnimationPlayer.stop(true)
#			animatedsprite.set_modulate(00000000)
			hide()
			go_to_checkpoint()

		CALLING:
			pass

		SADNESS:
			pass
#The purpose of "sad" states is to activate these when the other character dies
#The idea being that one character would be sad if the other dies and also an excuse to "deactivate" both characters when a life is lost
#Specially before respawn



		PUSH:
			$CollisionShape2D.shape.extents = Vector2(25.5, 122)
			$CollisionShape2D.position = Vector2(-1.5, -123)
			hurtboxcollision.shape.extents = Vector2(27, 123)
			hurtboxcollision.position = Vector2(-2, -123)
			$RopeCheck/CollisionShape2D.shape.extents = Vector2(6.625, 30.75)
			$RopeCheck/CollisionShape2D.position = Vector2(-0.375, 30)
			$PortalCheck/CollisionShape2D.shape.extents = Vector2(27, 123)
			$PortalCheck/CollisionShape2D.position = Vector2(-2, -123)
			pushcheck()
			WALK_MAX_SPEED = 700
			if Input.get_action_strength("right"):
				velocity.x = WALK_MAX_SPEED
				playerhitboxcollision.position = Vector2(65, 2)
				pushdetector.position = Vector2(63, 0)
			elif Input.get_action_strength("left"):
				velocity.x = -WALK_MAX_SPEED
				playerhitboxcollision.position = Vector2(-67, 2)
				pushdetector.position = Vector2(-59, 0)
			else:
				velocity.x = 0


			if Input.get_action_strength("right") and is_on_floor():
				animatedsprite.animation = "Pushing"
				animatedsprite.flip_h = false
			elif Input.get_action_strength("left") and is_on_floor():
				animatedsprite.animation = "Pushing"
				animatedsprite.flip_h = true
			else:
				animatedsprite.animation = "Idle"

			velocity.y += gravity * delta

	
			velocity = move_and_slide_with_snap(velocity, Vector2.DOWN, Vector2.UP)

			if is_on_floor() and Input.is_action_just_pressed("jumpup"):
				velocity.y = -JUMP_SPEED

			if velocity.y < 0 and not is_on_floor():
				if ouch == false:
					animatedsprite.animation = "Jumpgoesup"
				elif ouch == true:
					animatedsprite.animation = "Hurt"
				if Input.is_action_just_pressed("right"):
					animatedsprite.flip_h = false
				elif Input.is_action_just_pressed("left"):
					animatedsprite.flip_h = true
			elif velocity.y > 0 and not is_on_floor():
				if ouch == false:
					animatedsprite.animation = "Jumpgoesdown"
				elif ouch == true:
					animatedsprite.animation = "Hurt"
				if Input.is_action_just_pressed("right"):
					animatedsprite.flip_h = false
				elif Input.is_action_just_pressed("left"):
					animatedsprite.flip_h = true

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
			if is_on_slow():
				state = SLOW
			if is_on_ice():
				state = ICE

func is_invul():
	print("does it work")
	$FloaterActive.show()
#	animatedsprite.modulate = Color(0, 255, 0, 255)
	hurtbox.set_monitoring(false)
	yield(get_tree().create_timer(30), "timeout")
	print("hope it did")
	hurtbox.set_monitoring(true)
	$FloaterActive.hide()
#	animatedsprite.modulate = Color(255, 255, 255, 255)

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

func is_on_slow():
	if not slowCheck.is_colliding(): return false
	var collider = slowCheck.get_collider()
	if not collider is SlowFloor: return false
	return true

func _on_Hurtbox_area_entered(area):
	if area.name == "EnemyHitbox":
		ouch = true
		$AnimationPlayer.play("playerhurt") 
		health -= 10
		velocity.y -= 700
		yield(get_tree().create_timer(0.5), "timeout")
		ouch = false

func pushcheck():
	for index in get_slide_count():
		var collision = get_slide_collision(index)
		if collision.collider is PushableCopy:
			collision.collider.slide(-collision.normal * (WALK_MAX_SPEED / 2) )
		else:
			return false
	return true

func _on_RopeCheck_area_entered(area):
	if area.is_in_group("Hook"):
		rope_part = area
		state = ROPE

func Teleport(area):
	for Teleportal in get_tree().get_nodes_in_group("Teleportal"):
		if Teleportal != area:
			if(Teleportal.id == area.id):
				if(!Teleportal.lockPortal):
					area.LockedPortal()
					global_position = Teleportal.global_position

func _on_PortalCheck_area_entered(area):
	if(area.is_in_group("Teleportal")):
		if(!area.lockPortal):
			Teleport(area)

func go_to_checkpoint():
	var thing = checkpointTween.interpolate_property(self, "position", position, last_checkpoint.global_position, 1, Tween.TRANS_EXPO, Tween.EASE_OUT)
	thing = checkpointTween.start()
#	yield(get_tree().create_timer(0.4), "timeout")
	state = MAINSTATE
	health = 100
	yield(get_tree().create_timer(0.6), "timeout")
	hurtbox.set_monitoring(true)
#	animatedsprite.set_modulate(00000000)
	show()
	animatedsprite.animation = "Jumpgoesdown"
	$AnimationPlayer.play("playerhurt")

#ANIMATIONPLAYER ANIMATION NAMES
#Abouttokick DONE
#Abouttostab DONE
#Climbidle DONE
#Climbing DONE
#Dead DONE
#Hurt NOTYET
#Iceslide DONE
#Idle DONE
#Jumpgoesup DONE
#Kickedtheball DONE
#Pushing NOTYET
#Ropeattach DONE
#Running DONE
#Stabtheknife DONE
#Swimidle DONE
#Swimming DONE
#Jumpgoesdown DONE

#AND THIS IS FOR COMP4
#Idle
#Jumpgoesup
#Jumpgoesdown
#Hurt
#Dead
#Climbing
#Climbidle
#Running
#Iceslide
#Pushing
#Swimming
#Swimidle
#Crawlidle
#Crawlling

func _on_PushDetector_area_entered(area):
	if area.name == "PushArea":
		if state == MAINSTATE:
			state = PUSH

func _on_PushDetector_area_exited(area):
	if area.name == "PushArea":
		if state == PUSH:
			state = MAINSTATE
