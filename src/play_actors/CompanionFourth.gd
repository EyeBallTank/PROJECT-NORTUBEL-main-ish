extends KinematicBody2D
class_name Companion

#This character is a replacement for CompanionCopy. The main goal is that it does not use OS.get_ticks_msec() or even Time.get_ticks_msec()
#As of writing this, their hurtbox was somehow fixed? Turns out it's me checking animation Player and not realizing that when i check it, i forget to turn back on the Hurtbox.

enum {
	FOLLOWME,
	STANDSTILL,
	CRAWLIDLE,
	CRAWLFOLLOW,
	CRAWLRUN,
	CLIMBIDLE,
	CLIMBMOVE,
	CLIMBRUN,
	PUSHFOLLOW,
	PUSHRUN,
	DEATH,
	HURT,
#	HURTFOLLOW
#	HURTRUN
#	HURTIDLE
	SLOWRUN,
	SLOWFOLLOW,
	ICEIDLE,
	ICEFOLLOW,
	ICERUN,
	SWIMIDLE,
	SWIMMING,
	SWIMRUN,
	RUNAWAY,
	SADNESS,
	PLAYABLENORMAL,
	PLAYABLECLIMB,
	PLAYABLEICE,
	PLAYABLESWIM,
	PLAYABLECRAWL,
	PLAYABLEPUSH,
	PLAYABLESLOW
}

var climbspeed = 360
var state = STANDSTILL

var WALK_FORCE = 1600
var WALK_MAX_SPEED = 70
var PUSH_SPEED = 25
var STOP_FORCE = 450
var JUMP_SPEED = 1450

export var companionskin = "res://assets/sprites/play_actor_sprites/OscarSprites.tres"

export var speed: = Vector2(300.0, 1000.0)
export var gravity: = 1450.0
#export var oxygen : int = 70
export (float, 0, 1.0) var friction = 0.1
export (float, 0, 1.0) var acceleration = 0.25

var vel: = Vector2.ZERO
var direction: = Vector2.ZERO
onready var Player = get_parent().get_node("Player")

onready var healthBar = $CanvasLayer/HealthbarCompanion
onready var oxygenbar = $CanvasLayer/OxygenbarCompanion
export var health : int = 50
export var oxygen : int = 1500
onready var CompanionHurtbox = $CompanionHurtbox
onready var swimCheck = $SwimCheck
onready var ladderCheck = $LadderCheck
onready var slowCheck = $SlowCheck
onready var iceCheck = $IceCheck
var portal_id = 0
onready var animatedsprite = $AnimatedSprite
onready var pushdetector = $PushDetector

onready var compstateteller = $CanvasLayer/CompStateTeller

var last_checkpoint: Area2D = null
onready var checkpointTween = $CheckpointTween
var ouch = false
var immortal = false

onready var audioplayer = $AudioStreamPlayer
var was_on_floor = true

func _ready():
	$Camera2D.current = false
	Signals.connect("you_are_invincible", self, "_i_am_invincible")
	Signals.connect("player_died", self, "_on_Player_Died")
	immortal = false
	oxygenbar.hide()
	$FloaterActive.hide()
	animatedsprite.frames = load(companionskin)
	healthBar.max_value = health
	oxygenbar.max_value = oxygen
	var companionspawn = get_parent().get_node("companionspawn")
	last_checkpoint = companionspawn

func _i_am_invincible():
	is_invul()

func _on_Player_Died():
	if state == FOLLOWME:
		state = STANDSTILL
	if state == RUNAWAY:
		state = STANDSTILL
	if state == CRAWLFOLLOW:
		state = CRAWLIDLE
	if state == CRAWLRUN:
		state = CRAWLIDLE
	if state == CLIMBMOVE:
		state = CLIMBIDLE
	if state == CLIMBRUN:
		state = CLIMBIDLE
	if state == PUSHFOLLOW:
		state = STANDSTILL
	if state == PUSHRUN:
		state = STANDSTILL
	if state == SLOWRUN:
		state = STANDSTILL
	if state == SLOWFOLLOW:
		state = STANDSTILL
	if state == ICERUN:
		state = ICEIDLE
	if state == ICEFOLLOW:
		state = ICEIDLE
	if state == SWIMRUN:
		state = SWIMIDLE
	if state == SWIMMING:
		state = SWIMIDLE

func _physics_process(delta):
	if Input.is_action_just_pressed("charnormal"):
		$Camera2D.current = true
	elif Input.is_action_just_pressed("charswitch"):
		$Camera2D.current = false
	
	if Input.is_action_just_pressed("cameratest") and $Camera2D.smoothing_enabled == false:
		$Camera2D.smoothing_enabled = true
	elif Input.is_action_just_pressed("cameratest") and $Camera2D.smoothing_enabled == true:
		$Camera2D.smoothing_enabled = false

	healthBar.value = health
	if health <= 0  and state != DEATH:
		state = DEATH
		Signals.lives -= 1
		Signals.emit_signal("life_lost")
	oxygenbar.value = oxygen
	if oxygen <= 0  and state != DEATH:
		state = DEATH
		Signals.lives -= 1
		Signals.emit_signal("life_lost")

	match state:
		FOLLOWME:
			if Input.is_action_just_pressed("charnormal"):
				state = PLAYABLENORMAL

			compstateteller.play("followstate")
			oxygenbar.hide()
			$CompanionHurtbox/CollisionShape2D.shape.extents = Vector2(23, 82)
			$CompanionHurtbox/CollisionShape2D.position = Vector2(0, -81)
			$PortalCheck/CollisionShape2D.shape.extents = Vector2(23, 82)
			$PortalCheck/CollisionShape2D.position = Vector2(0, -81)
			$CollisionShape2D.shape.extents = Vector2(23, 82)
			$CollisionShape2D.position = Vector2(0, -81)
			
			pushcheck()
			if Player.global_position.x < global_position.x - 10:
				vel.x = -WALK_MAX_SPEED
				direction.x = -1
			elif Player.global_position.x > global_position.x + 10:
				vel.x = WALK_MAX_SPEED
				direction.x = 1
			else:
				vel.x = 0
				direction.x = 0
			vel.x = direction.x * 550

			if direction.x == 1 and is_on_floor():
				animatedsprite.animation = "Running"
				animatedsprite.flip_h = false
				pushdetector.position = Vector2(53, 0)
			elif direction.x == -1 and is_on_floor():
				animatedsprite.animation = "Running"
				animatedsprite.flip_h = true
				pushdetector.position = Vector2(-52, 0)
			else:
				animatedsprite.animation = "Idle"

			vel.y += gravity * delta
			gravity = 1450.0
			vel = move_and_slide_with_snap(vel, Vector2.DOWN, Vector2.UP)

			if is_on_floor() and Input.is_action_just_pressed("interactcomp"):
				vel.y = -JUMP_SPEED
				if vel.y < 0:
					vel.y += 500

			if vel.y < 0 and not is_on_floor():
				if ouch == false:
					animatedsprite.animation = "Jumpgoesup"
				elif ouch == true:
					animatedsprite.animation = "Hurt"
				if direction.x == 1:
					animatedsprite.flip_h = false
				elif direction.x == -1:
					animatedsprite.flip_h = true
			elif vel.y > 0 and not is_on_floor():
				if ouch == false:
					animatedsprite.animation = "Jumpgoesdown"
				elif ouch == true:
					animatedsprite.animation = "Hurt"
				if direction.x == 1:
					animatedsprite.flip_h = false
				elif direction.x == -1:
					animatedsprite.flip_h = true

			if is_on_floor() and not was_on_floor:
				audioplayer.play()
			was_on_floor = is_on_floor()

			if Input.is_action_pressed("kickball") and Input.is_action_just_pressed("left"):
				state = RUNAWAY
			if Input.is_action_pressed("kickball") and Input.is_action_just_pressed("down"):
				state = STANDSTILL
			if is_on_water():
				Signals.emit_signal("touch_water")
				state = SWIMMING
			if is_on_ladder():
				if Input.is_action_just_pressed("interactcomp"):
					state = CLIMBIDLE
			if is_on_slow():
				state = SLOWFOLLOW
			if is_on_ice():
				state = ICEFOLLOW

			if Input.is_action_just_pressed("simplerunaway"):
				state = RUNAWAY
			if Input.is_action_just_pressed("simplestandstill"):
				state = STANDSTILL

		STANDSTILL:
			if Input.is_action_just_pressed("charnormal"):
				state = PLAYABLENORMAL
			compstateteller.play("stopstate")
			oxygenbar.hide()
			$CompanionHurtbox/CollisionShape2D.shape.extents = Vector2(23, 82)
			$CompanionHurtbox/CollisionShape2D.position = Vector2(0, -81)
			$PortalCheck/CollisionShape2D.shape.extents = Vector2(23, 82)
			$PortalCheck/CollisionShape2D.position = Vector2(0, -81)
			$CollisionShape2D.shape.extents = Vector2(23, 82)
			$CollisionShape2D.position = Vector2(0, -81)

			pushcheck()
			vel.x = 0
			direction.x = 0
			vel.x = direction.x * 0

			if is_on_floor() and Input.is_action_just_pressed("interactcomp"):
				vel.y = -JUMP_SPEED
				if vel.y < 0:
					vel.y += 500

			vel.y += gravity * delta
			gravity = 1450.0
			vel = move_and_slide_with_snap(vel, Vector2.DOWN, Vector2.UP)

			if is_on_floor() and not was_on_floor:
				audioplayer.play()
			was_on_floor = is_on_floor()

			if vel.y < 0 and not is_on_floor():
				if ouch == false:
					animatedsprite.animation = "Jumpgoesup"
				elif ouch == true:
					animatedsprite.animation = "Hurt"
				if direction.x == 1:
					animatedsprite.flip_h = false
				elif direction.x == -1:
					animatedsprite.flip_h = true
			elif vel.y > 0 and not is_on_floor():
				if ouch == false:
					animatedsprite.animation = "Jumpgoesdown"
				elif ouch == true:
					animatedsprite.animation = "Hurt"
				if direction.x == 1:
					animatedsprite.flip_h = false
				elif direction.x == -1:
					animatedsprite.flip_h = true

			if is_on_floor():
				animatedsprite.animation = "Idle"

			if Input.is_action_pressed("kickball") and Input.is_action_just_pressed("right"):
				state = FOLLOWME
			if Input.is_action_pressed("kickball") and Input.is_action_just_pressed("left"):
				state = RUNAWAY
			if is_on_water():
				Signals.emit_signal("touch_water")
				state = SWIMIDLE
			if is_on_ladder():
				if Input.is_action_just_pressed("interactcomp"):
					state = CLIMBIDLE
			if is_on_ice():
				state = ICEIDLE

			if Input.is_action_just_pressed("simplerunaway"):
				state = RUNAWAY
			if Input.is_action_just_pressed("simplefollow"):
				state = FOLLOWME

		RUNAWAY:
			if Input.is_action_just_pressed("charnormal"):
				state = PLAYABLENORMAL
			compstateteller.play("runstate")
			oxygenbar.hide()
			$CompanionHurtbox/CollisionShape2D.shape.extents = Vector2(23, 82)
			$CompanionHurtbox/CollisionShape2D.position = Vector2(0, -81)
			$PortalCheck/CollisionShape2D.shape.extents = Vector2(23, 82)
			$PortalCheck/CollisionShape2D.position = Vector2(0, -81)
			$CollisionShape2D.shape.extents = Vector2(23, 82)
			$CollisionShape2D.position = Vector2(0, -81)

			pushcheck()
			if Player.global_position.x < global_position.x - 10:
				vel.x = WALK_MAX_SPEED
				direction.x = 1
			elif Player.global_position.x > global_position.x + 10:
				vel.x = -WALK_MAX_SPEED
				direction.x = -1
			else:
				vel.x = 0
				direction.x = 0
			vel.x = direction.x * 550
	
	
			vel.y += gravity * delta
			gravity = 1450.0
			vel = move_and_slide_with_snap(vel, Vector2.DOWN, Vector2.UP)

			if is_on_floor() and not was_on_floor:
				audioplayer.play()
			was_on_floor = is_on_floor()

			if direction.x == 1 and is_on_floor():
				animatedsprite.animation = "Running"
				animatedsprite.flip_h = false
				pushdetector.position = Vector2(53, 0)
			elif direction.x == -1 and is_on_floor():
				animatedsprite.animation = "Running"
				animatedsprite.flip_h = true
				pushdetector.position = Vector2(-52, 0)
			else:
				animatedsprite.animation = "Idle"

			if is_on_floor() and Input.is_action_just_pressed("interactcomp"):
				vel.y = -JUMP_SPEED
				if vel.y < 0:
					vel.y += 500

			if vel.y < 0 and not is_on_floor():
				if ouch == false:
					animatedsprite.animation = "Jumpgoesup"
				elif ouch == true:
					animatedsprite.animation = "Hurt"
				if direction.x == 1:
					animatedsprite.flip_h = false
				elif direction.x == -1:
					animatedsprite.flip_h = true
			elif vel.y > 0 and not is_on_floor():
				if ouch == false:
					animatedsprite.animation = "Jumpgoesdown"
				elif ouch == true:
					animatedsprite.animation = "Hurt"
				if direction.x == 1:
					animatedsprite.flip_h = false
				elif direction.x == -1:
					animatedsprite.flip_h = true

			if Input.is_action_pressed("kickball") and Input.is_action_just_pressed("right"):
				state = FOLLOWME
			if Input.is_action_pressed("kickball") and Input.is_action_just_pressed("down"):
				state = STANDSTILL
			if is_on_water():
				Signals.emit_signal("touch_water")
				state = SWIMRUN
			if is_on_ladder():
				if Input.is_action_just_pressed("interactcomp"):
					state = CLIMBIDLE
			if is_on_slow():
				state = SLOWRUN
			if is_on_ice():
				state = ICERUN

			if Input.is_action_just_pressed("simplefollow"):
				state = FOLLOWME
			if Input.is_action_just_pressed("simplestandstill"):
				state = STANDSTILL

		SWIMMING:
			if Input.is_action_just_pressed("charnormal"):
				state = PLAYABLESWIM

			compstateteller.play("followstate")
			if immortal == false:
				oxygenbar.show()
				oxygen -= 1
			elif immortal == true:
				oxygenbar.hide()
				oxygen = 1500
#			if Player:
#				vel = position.direction_to(Player.position) * speed
#			if Player.global_position.x < global_position.x - 10:
#				if Player.global_position.y < global_position.y - 10:
#					vel = position.direction_to(Player.position) * speed
#					direction.x = -1
#					direction.y = -1
#				elif Player.global_position.y > global_position.y + 10:
#					vel = position.direction_to(Player.position) * speed
#					direction.x = -1
#					direction.y = 1
#			elif Player.global_position.x > global_position.x + 10:
#				if Player.global_position.y < global_position.y - 10:
#					vel = position.direction_to(Player.position) * speed
#					direction.x = 1
#					direction.y = -1
#				elif Player.global_position.y > global_position.y + 10:
#					vel = position.direction_to(Player.position) * speed
#					direction.x = 1
#					direction.y = 1
#			if Player.global_position.x < global_position.x - 10:
#				vel = position.direction_to(Player.position) * speed.x
#			elif Player.global_position.x > global_position.x + 10:
#				vel = position.direction_to(Player.position) * speed.x
#			elif Player.global_position.y < global_position.y - 10:
#				vel = position.direction_to(Player.position) * speed.y
#			elif Player.global_position.y > global_position.y + 10:
#				vel = position.direction_to(Player.position) * speed.y
			if Player.global_position.x < global_position.x - 50:
				animatedsprite.flip_h = true
				pushdetector.position = Vector2(-52, 0)
				if Player.global_position.y < global_position.y - 50:
					vel = position.direction_to(Player.position) * speed.x
					vel = position.direction_to(Player.position) * speed.y
					direction.x = -1
					direction.y = -1
				elif Player.global_position.y > global_position.y + 50:
					vel = position.direction_to(Player.position) * speed.x
					vel = position.direction_to(Player.position) * speed.y
					direction.x = -1
					direction.y = 1
				else:
					vel = position.direction_to(Player.position) * speed.x
					direction.x = -1
			elif Player.global_position.x > global_position.x + 50:
				animatedsprite.flip_h = false
				pushdetector.position = Vector2(53, 0)
				if Player.global_position.y < global_position.y - 50:
					vel = position.direction_to(Player.position) * speed.x
					vel = position.direction_to(Player.position) * speed.y
					direction.x = 1
					direction.y = -1
				elif Player.global_position.y > global_position.y + 50:
					vel = position.direction_to(Player.position) * speed.x
					vel = position.direction_to(Player.position) * speed.y
					direction.x = 1
					direction.y = 1
				else:
					vel = position.direction_to(Player.position) * speed.x
					direction.x = 1
			else:
				if Player.global_position.y < global_position.y - 50:
					vel = position.direction_to(Player.position) * speed.x
					vel = position.direction_to(Player.position) * speed.y
					direction.y = -1
				elif Player.global_position.y > global_position.y + 50:
					vel = position.direction_to(Player.position) * speed.x
					vel = position.direction_to(Player.position) * speed.y
					direction.y = 1
				else:
					vel.x = 0
					direction.x = 0
					vel.y = 0
					direction.y = 0
			direction = direction.normalized()
			vel = vel.normalized()
			vel.x = direction.x * 350
			vel.y = direction.y * 350

#			$CompanionHurtbox/CollisionShape2D.shape.extents = Vector2(69.5, 41)
#			$CompanionHurtbox/CollisionShape2D.position = Vector2(0.5, -153)
#			$PortalCheck/CollisionShape2D.shape.extents = Vector2(69.5, 41)
#			$PortalCheck/CollisionShape2D.position = Vector2(0.5, -153)
#			$CollisionShape2D.shape.extents = Vector2(69.5, 41)
#			$CollisionShape2D.position = Vector2(0.5, -153)

			if direction.x == 1:
				if direction.y == -1:
					animatedsprite.animation = "Swimming"
					animatedsprite.flip_h = false
					pushdetector.position = Vector2(53, 0)
				elif direction.y == 1:
					animatedsprite.animation = "Swimming"
					animatedsprite.flip_h = false
					pushdetector.position = Vector2(53, 0)
				else:
					animatedsprite.animation = "Swimming"
					animatedsprite.flip_h = false
					pushdetector.position = Vector2(53, 0)
			elif direction.x == -1:
				if direction.y == -1:
					animatedsprite.animation = "Swimming"
					animatedsprite.flip_h = true
					pushdetector.position = Vector2(-52, 0)
				elif direction.y == 1:
					animatedsprite.animation = "Swimming"
					animatedsprite.flip_h = true
					pushdetector.position = Vector2(-52, 0)
				else:
					animatedsprite.animation = "Swimming"
					animatedsprite.flip_h = true
					pushdetector.position = Vector2(-52, 0)
			else:
				if direction.y == -1:
					animatedsprite.animation = "Swimup"
				elif direction.y == 1:
					animatedsprite.animation = "Swimdown"
				else:
					animatedsprite.animation = "Swimming"

#			vel.y += gravity * delta
			vel = move_and_slide_with_snap(vel, Vector2.DOWN, Vector2.UP)

			if Input.is_action_pressed("kickball") and Input.is_action_just_pressed("left"):
				state = SWIMRUN
			if Input.is_action_pressed("kickball") and Input.is_action_just_pressed("down"):
				state = SWIMIDLE
			if not is_on_water():
				oxygenbar.hide()
				oxygen = 1500
				state = FOLLOWME

			if Input.is_action_just_pressed("simplerunaway"):
				state = SWIMRUN
			if Input.is_action_just_pressed("simplestandstill"):
				state = SWIMIDLE

		SWIMRUN:
			if Input.is_action_just_pressed("charnormal"):
				state = PLAYABLESWIM

			compstateteller.play("runstate")
			if immortal == false:
				oxygenbar.show()
				oxygen -= 1
			elif immortal == true:
				oxygenbar.hide()
				oxygen = 1500
			if Player.global_position.x < global_position.x - 50:
				animatedsprite.flip_h = false
				pushdetector.position = Vector2(53, 0)
				if Player.global_position.y < global_position.y - 50:
					vel = position.direction_to(Player.position) * speed.x
					vel = position.direction_to(Player.position) * speed.y
					direction.x = 1
					direction.y = 1
				elif Player.global_position.y > global_position.y + 50:
					vel = position.direction_to(Player.position) * speed.x
					vel = position.direction_to(Player.position) * speed.y
					direction.x = 1
					direction.y = -1
				else:
					vel = position.direction_to(Player.position) * speed.x
					direction.x = 1
			elif Player.global_position.x > global_position.x + 50:
				animatedsprite.flip_h = true
				pushdetector.position = Vector2(-52, 0)
				if Player.global_position.y < global_position.y - 50:
					vel = position.direction_to(Player.position) * speed.x
					vel = position.direction_to(Player.position) * speed.y
					direction.x = -1
					direction.y = 1
				elif Player.global_position.y > global_position.y + 50:
					vel = position.direction_to(Player.position) * speed.x
					vel = position.direction_to(Player.position) * speed.y
					direction.x = -1
					direction.y = -1
				else:
					vel = position.direction_to(Player.position) * speed.x
					direction.x = -1
			else:
				if Player.global_position.y < global_position.y - 50:
					vel = position.direction_to(Player.position) * speed.x
					vel = position.direction_to(Player.position) * speed.y
					direction.y = 1
				elif Player.global_position.y > global_position.y + 50:
					vel = position.direction_to(Player.position) * speed.x
					vel = position.direction_to(Player.position) * speed.y
					direction.y = -1
				else:
					vel.x = 0
					direction.x = 0
					vel.y = 0
					direction.y = 0
			direction = direction.normalized()
			vel = vel.normalized()
			vel.x = direction.x * 350
			vel.y = direction.y * 350

#			$CompanionHurtbox/CollisionShape2D.shape.extents = Vector2(69.5, 41)
#			$CompanionHurtbox/CollisionShape2D.position = Vector2(0.5, -153)
#			$PortalCheck/CollisionShape2D.shape.extents = Vector2(69.5, 41)
#			$PortalCheck/CollisionShape2D.position = Vector2(0.5, -153)
#			$CollisionShape2D.shape.extents = Vector2(69.5, 41)
#			$CollisionShape2D.position = Vector2(0.5, -153)

			if direction.x == 1:
				if direction.y == -1:
					animatedsprite.animation = "Swimming"
					animatedsprite.flip_h = false
					pushdetector.position = Vector2(53, 0)
				elif direction.y == 1:
					animatedsprite.animation = "Swimming"
					animatedsprite.flip_h = false
					pushdetector.position = Vector2(53, 0)
				else:
					animatedsprite.animation = "Swimming"
					animatedsprite.flip_h = false
					pushdetector.position = Vector2(53, 0)
			elif direction.x == -1:
				if direction.y == -1:
					animatedsprite.animation = "Swimming"
					animatedsprite.flip_h = true
					pushdetector.position = Vector2(-52, 0)
				elif direction.y == 1:
					animatedsprite.animation = "Swimming"
					animatedsprite.flip_h = true
					pushdetector.position = Vector2(-52, 0)
				else:
					animatedsprite.animation = "Swimming"
					animatedsprite.flip_h = true
					pushdetector.position = Vector2(-52, 0)
			else:
				if direction.y == -1:
					animatedsprite.animation = "Swimming"
				elif direction.y == 1:
					animatedsprite.animation = "Swimming"
				else:
					animatedsprite.animation = "Swimming"

#			vel.y += gravity * delta
			vel = move_and_slide_with_snap(vel, Vector2.DOWN, Vector2.UP)

			if Input.is_action_pressed("kickball") and Input.is_action_just_pressed("right"):
				state = SWIMMING
			if Input.is_action_pressed("kickball") and Input.is_action_just_pressed("down"):
				state = SWIMIDLE
			if not is_on_water():
				oxygenbar.hide()
				oxygen = 1500
				state = RUNAWAY

			if Input.is_action_just_pressed("simplefollow"):
				state = SWIMMING
			if Input.is_action_just_pressed("simplestandstill"):
				state = SWIMIDLE

		SWIMIDLE:
			if Input.is_action_just_pressed("charnormal"):
				state = PLAYABLESWIM
			compstateteller.play("stopstate")
			if immortal == false:
				oxygenbar.show()
				oxygen -= 1
			elif immortal == true:
				oxygenbar.hide()
				oxygen = 1500
			animatedsprite.animation = "Swimidle"
			vel.x = 0
			direction.x = 0
			vel.x = direction.x * 0
			vel.y = 85
			direction.y = 0
#			vel.y = direction.y * 450
			vel.y += gravity * delta
			gravity = 10.0
			vel = move_and_slide_with_snap(vel, Vector2.DOWN, Vector2.UP)

#			$CompanionHurtbox/CollisionShape2D.shape.extents = Vector2(69.5, 41)
#			$CompanionHurtbox/CollisionShape2D.position = Vector2(0.5, -153)
#			$PortalCheck/CollisionShape2D.shape.extents = Vector2(69.5, 41)
#			$PortalCheck/CollisionShape2D.position = Vector2(0.5, -153)
#			$CollisionShape2D.shape.extents = Vector2(69.5, 41)
#			$CollisionShape2D.position = Vector2(0.5, -153)

			if Input.is_action_pressed("kickball") and Input.is_action_just_pressed("left"):
				state = SWIMRUN
			if Input.is_action_pressed("kickball") and Input.is_action_just_pressed("right"):
				state = SWIMMING
			if not is_on_water():
				oxygenbar.hide()
				oxygen = 1500
				state = STANDSTILL

			if Input.is_action_just_pressed("simplefollow"):
				state = SWIMMING
			if Input.is_action_just_pressed("simplerunaway"):
				state = SWIMRUN


		CLIMBIDLE:
			if Input.is_action_just_pressed("charnormal"):
				state = PLAYABLECLIMB
			compstateteller.play("stopstate")
			oxygenbar.hide()
			$CompanionHurtbox/CollisionShape2D.shape.extents = Vector2(23, 82)
			$CompanionHurtbox/CollisionShape2D.position = Vector2(0, -81)
			$PortalCheck/CollisionShape2D.shape.extents = Vector2(23, 82)
			$PortalCheck/CollisionShape2D.position = Vector2(0, -81)
			$CollisionShape2D.shape.extents = Vector2(23, 82)
			$CollisionShape2D.position = Vector2(0, -81)

			if Player.global_position.y < global_position.y - 30:
				if Player.global_position.x < global_position.x - 90:
					animatedsprite.animation = "Climbidle"
					vel.x = 0
					direction.x = 0
					vel.y = 0
					direction.y = 0
				elif Player.global_position.x > global_position.x + 90:
					animatedsprite.animation = "Climbidle"
					vel.x = 0
					direction.x = 0
					vel.y = 0
					direction.y = 0
				else:
					animatedsprite.animation = "Climbidle"
					vel.x = 0
					direction.x = 0
					vel.y = 0
					direction.y = 0
			elif Player.global_position.y > global_position.y + 30:
				if Player.global_position.x < global_position.x - 90:
					animatedsprite.animation = "Climbidle"
					vel.x = 0
					direction.x = 0
					vel.y = 0
					direction.y = 0
				elif Player.global_position.x > global_position.x + 90:
					animatedsprite.animation = "Climbidle"
					vel.x = 0
					direction.x = 0
					vel.y = 0
					direction.y = 0
				else:
					animatedsprite.animation = "Climbidle"
					vel.x = 0
					direction.x = 0
					vel.y = 0
					direction.y = 0
			else:
				if Player.global_position.x < global_position.x - 90:
					animatedsprite.animation = "Climbidle"
					vel.x = 0
					direction.x = 0
					vel.y = 0
					direction.y = 0
				elif Player.global_position.x > global_position.x + 90:
					animatedsprite.animation = "Climbidle"
					vel.x = 0
					direction.x = 0
					vel.y = 0
					direction.y = 0
				else:
					animatedsprite.animation = "Climbidle"
					vel.x = 0
					direction.x = 0
					vel.y = 0
					direction.y = 0

			if Input.is_action_pressed("kickball") and Input.is_action_just_pressed("right"):
				state = CLIMBMOVE
			if Input.is_action_pressed("kickball") and Input.is_action_just_pressed("left"):
				state = CLIMBRUN
			if Input.is_action_just_pressed("interactcomp"):
				state = STANDSTILL
			if not is_on_ladder():
				state = STANDSTILL

			if Input.is_action_just_pressed("simplefollow"):
				state = CLIMBMOVE
			if Input.is_action_just_pressed("simplerunaway"):
				state = CLIMBRUN

		CLIMBMOVE:
			if Input.is_action_just_pressed("charnormal"):
				state = PLAYABLECLIMB

			compstateteller.play("followstate")
			oxygenbar.hide()
			$CompanionHurtbox/CollisionShape2D.shape.extents = Vector2(23, 82)
			$CompanionHurtbox/CollisionShape2D.position = Vector2(0, -81)
			$PortalCheck/CollisionShape2D.shape.extents = Vector2(23, 82)
			$PortalCheck/CollisionShape2D.position = Vector2(0, -81)
			$CollisionShape2D.shape.extents = Vector2(23, 82)
			$CollisionShape2D.position = Vector2(0, -81)

#			if Player:
#				vel = position.direction_to(Player.position) * speed
			if Player.global_position.y < global_position.y - 30:
				if Player.global_position.x < global_position.x - 90:
					vel = position.direction_to(Player.position) * climbspeed
					animatedsprite.animation = "Climbing"
				elif Player.global_position.x > global_position.x + 90:
					vel = position.direction_to(Player.position) * climbspeed
					animatedsprite.animation = "Climbing"
				else:
					vel = position.direction_to(Player.position) * climbspeed
					animatedsprite.animation = "Climbing"
			elif Player.global_position.y > global_position.y + 30:
				if Player.global_position.x < global_position.x - 90:
					vel = position.direction_to(Player.position) * climbspeed
					animatedsprite.animation = "Climbing"
				elif Player.global_position.x > global_position.x + 90:
					vel = position.direction_to(Player.position) * climbspeed
					animatedsprite.animation = "Climbing"
				else:
					vel = position.direction_to(Player.position) * climbspeed
					animatedsprite.animation = "Climbing"
			else:
				if Player.global_position.x < global_position.x - 90:
					animatedsprite.animation = "Climbidle"
					vel.x = 0
					direction.x = 0
					vel.y = 0
					direction.y = 0
				elif Player.global_position.x > global_position.x + 90:
					animatedsprite.animation = "Climbidle"
					vel.x = 0
					direction.x = 0
					vel.y = 0
					direction.y = 0
				else:
					animatedsprite.animation = "Climbidle"
					vel.x = 0
					direction.x = 0
					vel.y = 0
					direction.y = 0

			vel.x = direction.x * 390
#Why do i have to use vel.x and not vel.y here?
			vel = move_and_slide_with_snap(vel, Vector2.DOWN, Vector2.UP)

			if Input.is_action_pressed("kickball") and Input.is_action_just_pressed("down"):
				state = CLIMBIDLE
			if Input.is_action_pressed("kickball") and Input.is_action_just_pressed("left"):
				state = CLIMBRUN
			if Input.is_action_just_pressed("interactcomp"):
				state = FOLLOWME
			if not is_on_ladder():
				state = FOLLOWME

			if Input.is_action_just_pressed("simplestandstill"):
				state = CLIMBIDLE
			if Input.is_action_just_pressed("simplerunaway"):
				state = CLIMBRUN

		CLIMBRUN:
			if Input.is_action_just_pressed("charnormal"):
				state = PLAYABLECLIMB
			compstateteller.play("runstate")
			oxygenbar.hide()
			$CompanionHurtbox/CollisionShape2D.shape.extents = Vector2(23, 82)
			$CompanionHurtbox/CollisionShape2D.position = Vector2(0, -81)
			$PortalCheck/CollisionShape2D.shape.extents = Vector2(23, 82)
			$PortalCheck/CollisionShape2D.position = Vector2(0, -81)
			$CollisionShape2D.shape.extents = Vector2(23, 82)
			$CollisionShape2D.position = Vector2(0, -81)

#			if Player:
#				vel = position.direction_to(Player.position) * speed
			if Player.global_position.y < global_position.y - 30:
				if Player.global_position.x < global_position.x - 90:
					vel = position.direction_to(Player.position) * -climbspeed
					animatedsprite.animation = "Climbing"
				elif Player.global_position.x > global_position.x + 90:
					vel = position.direction_to(Player.position) * -climbspeed
					animatedsprite.animation = "Climbing"
				else:
					vel = position.direction_to(Player.position) * -climbspeed
					animatedsprite.animation = "Climbing"
			elif Player.global_position.y > global_position.y + 30:
				if Player.global_position.x < global_position.x - 90:
					vel = position.direction_to(Player.position) * -climbspeed
					animatedsprite.animation = "Climbing"
				elif Player.global_position.x > global_position.x + 90:
					vel = position.direction_to(Player.position) * -climbspeed
					animatedsprite.animation = "Climbing"
				else:
					vel = position.direction_to(Player.position) * -climbspeed
					animatedsprite.animation = "Climbing"
			else:
				if Player.global_position.x < global_position.x - 90:
					animatedsprite.animation = "Climbidle"
					vel.x = 0
					direction.x = 0
					vel.y = 0
					direction.y = 0
				elif Player.global_position.x > global_position.x + 90:
					animatedsprite.animation = "Climbidle"
					vel.x = 0
					direction.x = 0
					vel.y = 0
					direction.y = 0
				else:
#					animatedsprite.animation = "Climbidle"
#					vel.x = 0
#					direction.x = 0
#					vel.y = 0
#					direction.y = 0
					pass

			vel.x = direction.x * 390
#Why do i have to use vel.x and not vel.y here?
			vel = move_and_slide_with_snap(vel, Vector2.DOWN, Vector2.UP)

			if Input.is_action_pressed("kickball") and Input.is_action_just_pressed("down"):
				state = CLIMBIDLE
			if Input.is_action_pressed("kickball") and Input.is_action_just_pressed("right"):
				state = CLIMBMOVE
			if Input.is_action_just_pressed("interactcomp"):
				state = RUNAWAY
			if not is_on_ladder():
				state = RUNAWAY

			if Input.is_action_just_pressed("simplefollow"):
				state = CLIMBMOVE
			if Input.is_action_just_pressed("simplestandstill"):
				state = CLIMBIDLE

		SLOWFOLLOW:
			compstateteller.play("followstate")
			oxygenbar.hide()
			$CompanionHurtbox/CollisionShape2D.shape.extents = Vector2(23, 82)
			$CompanionHurtbox/CollisionShape2D.position = Vector2(0, -81)
			$PortalCheck/CollisionShape2D.shape.extents = Vector2(23, 82)
			$PortalCheck/CollisionShape2D.position = Vector2(0, -81)
			$CollisionShape2D.shape.extents = Vector2(23, 82)
			$CollisionShape2D.position = Vector2(0, -81)

			pushcheck()
			if Player.global_position.x < global_position.x - 10:
				vel.x = PUSH_SPEED
				direction.x = -1
			elif Player.global_position.x > global_position.x + 10:
				vel.x = -PUSH_SPEED
				direction.x = 1
			else:
				vel.x = 0
				direction.x = 0
			vel.x = direction.x * 130

			vel.y += gravity * delta
			gravity = 1450.0
			vel = move_and_slide_with_snap(vel, Vector2.DOWN, Vector2.UP)

			if is_on_floor() and not was_on_floor:
				audioplayer.play()
			was_on_floor = is_on_floor()

			if direction.x == 1 and is_on_floor():
				animatedsprite.animation = "Running"
				animatedsprite.flip_h = false
				pushdetector.position = Vector2(53, 0)
			elif direction.x == -1 and is_on_floor():
				animatedsprite.animation = "Running"
				animatedsprite.flip_h = true
				pushdetector.position = Vector2(-52, 0)
			else:
				animatedsprite.animation = "Idle"

			if is_on_floor() and Input.is_action_just_pressed("interactcomp"):
				vel.y = -JUMP_SPEED
				if vel.y < 0:
					vel.y += 500

			if vel.y < 0 and not is_on_floor():
				if ouch == false:
					animatedsprite.animation = "Jumpgoesup"
				elif ouch == true:
					animatedsprite.animation = "Hurt"
				if direction.x == 1:
					animatedsprite.flip_h = false
				elif direction.x == -1:
					animatedsprite.flip_h = true
			elif vel.y > 0 and not is_on_floor():
				if ouch == false:
					animatedsprite.animation = "Jumpgoesdown"
				elif ouch == true:
					animatedsprite.animation = "Hurt"
				if direction.x == 1:
					animatedsprite.flip_h = false
				elif direction.x == -1:
					animatedsprite.flip_h = true

			if Input.is_action_pressed("kickball") and Input.is_action_just_pressed("left"):
				state = SLOWRUN
			if Input.is_action_pressed("kickball") and Input.is_action_just_pressed("down"):
				state = STANDSTILL
			if is_on_water():
				Signals.emit_signal("touch_water")
				state = SWIMMING
			if is_on_ladder():
				if Input.is_action_just_pressed("interactcomp"):
					state = CLIMBIDLE
			if not is_on_slow():
				if is_on_floor():
					state = FOLLOWME

			if Input.is_action_just_pressed("simplerunaway"):
				state = SLOWRUN
			if Input.is_action_just_pressed("simplestandstill"):
				state = STANDSTILL


		SLOWRUN:
			compstateteller.play("runstate")
			oxygenbar.hide()
			$CompanionHurtbox/CollisionShape2D.shape.extents = Vector2(23, 82)
			$CompanionHurtbox/CollisionShape2D.position = Vector2(0, -81)
			$PortalCheck/CollisionShape2D.shape.extents = Vector2(23, 82)
			$PortalCheck/CollisionShape2D.position = Vector2(0, -81)
			$CollisionShape2D.shape.extents = Vector2(23, 82)
			$CollisionShape2D.position = Vector2(0, -81)

			pushcheck()
			if Player.global_position.x < global_position.x - 10:
				vel.x = PUSH_SPEED
				direction.x = 1
			elif Player.global_position.x > global_position.x + 10:
				vel.x = -PUSH_SPEED
				direction.x = -1
			else:
				vel.x = 0
				direction.x = 0
			vel.x = direction.x * 130

			vel.y += gravity * delta
			gravity = 1450.0
			vel = move_and_slide_with_snap(vel, Vector2.DOWN, Vector2.UP)

			if is_on_floor() and not was_on_floor:
				audioplayer.play()
			was_on_floor = is_on_floor()

			if direction.x == 1 and is_on_floor():
				animatedsprite.animation = "Running"
				animatedsprite.flip_h = false
				pushdetector.position = Vector2(53, 0)
			elif direction.x == -1 and is_on_floor():
				animatedsprite.animation = "Running"
				animatedsprite.flip_h = true
				pushdetector.position = Vector2(-52, 0)
			else:
				animatedsprite.animation = "Idle"

			if is_on_floor() and Input.is_action_just_pressed("interactcomp"):
				vel.y = -JUMP_SPEED
				if vel.y < 0:
					vel.y += 500

			if vel.y < 0 and not is_on_floor():
				if ouch == false:
					animatedsprite.animation = "Jumpgoesup"
				elif ouch == true:
					animatedsprite.animation = "Hurt"
				if direction.x == 1:
					animatedsprite.flip_h = false
				elif direction.x == -1:
					animatedsprite.flip_h = true
			elif vel.y > 0 and not is_on_floor():
				if ouch == false:
					animatedsprite.animation = "Jumpgoesdown"
				elif ouch == true:
					animatedsprite.animation = "Hurt"
				if direction.x == 1:
					animatedsprite.flip_h = false
				elif direction.x == -1:
					animatedsprite.flip_h = true

			if Input.is_action_pressed("kickball") and Input.is_action_just_pressed("right"):
				state = SLOWFOLLOW
			if Input.is_action_pressed("kickball") and Input.is_action_just_pressed("down"):
				state = STANDSTILL
			if is_on_water():
				Signals.emit_signal("touch_water")
				state = SWIMRUN
			if is_on_ladder():
				if Input.is_action_just_pressed("interactcomp"):
					state = CLIMBIDLE
			if not is_on_slow():
				if is_on_floor():
					state = RUNAWAY

			if Input.is_action_just_pressed("simplefollow"):
				state = SLOWFOLLOW
			if Input.is_action_just_pressed("simplestandstill"):
				state = STANDSTILL

		CRAWLFOLLOW:
			compstateteller.play("followstate")
			oxygenbar.hide()
			if Player.global_position.x < global_position.x - 10:
				vel.x = -WALK_MAX_SPEED
				direction.x = -1
			elif Player.global_position.x > global_position.x + 10:
				vel.x = WALK_MAX_SPEED
				direction.x = 1
			else:
				vel.x = 0
				direction.x = 0
			vel.x = direction.x * 350

			if is_on_floor() and not was_on_floor:
				audioplayer.play()
			was_on_floor = is_on_floor()

			vel.y += gravity * delta
			gravity = 1450.0
			vel = move_and_slide_with_snap(vel, Vector2.DOWN, Vector2.UP)

			if direction.x == 1 and is_on_floor():
				animatedsprite.animation = "Crawlling"
				animatedsprite.flip_h = false
				pushdetector.position = Vector2(53, 0)
			elif direction.x == -1 and is_on_floor():
				animatedsprite.animation = "Crawlling"
				animatedsprite.flip_h = true
				pushdetector.position = Vector2(-52, 0)
			else:
				animatedsprite.animation = "Crawlidle"

			if Input.is_action_pressed("kickball") and Input.is_action_just_pressed("left"):
				state = CRAWLRUN
			if Input.is_action_pressed("kickball") and Input.is_action_just_pressed("down"):
				state = CRAWLIDLE

			if Input.is_action_just_pressed("simplerunaway"):
				state = CRAWLRUN
			if Input.is_action_just_pressed("simplestandstill"):
				state = CRAWLIDLE

		CRAWLRUN:
			compstateteller.play("runstate")
			oxygenbar.hide()
			if Player.global_position.x < global_position.x - 10:
				vel.x = WALK_MAX_SPEED
				direction.x = 1
			elif Player.global_position.x > global_position.x + 10:
				vel.x = -WALK_MAX_SPEED
				direction.x = -1
			else:
				vel.x = 0
				direction.x = 0
			vel.x = direction.x * 350

			vel.y += gravity * delta
			gravity = 1450.0
			vel = move_and_slide_with_snap(vel, Vector2.DOWN, Vector2.UP)

			if is_on_floor() and not was_on_floor:
				audioplayer.play()
			was_on_floor = is_on_floor()

			if direction.x == 1 and is_on_floor():
				animatedsprite.animation = "Crawlling"
				animatedsprite.flip_h = false
				pushdetector.position = Vector2(53, 0)
			elif direction.x == -1 and is_on_floor():
				animatedsprite.animation = "Crawlling"
				animatedsprite.flip_h = true
				pushdetector.position = Vector2(-52, 0)
			else:
				animatedsprite.animation = "Crawlidle"

			if Input.is_action_pressed("kickball") and Input.is_action_just_pressed("right"):
				state = CRAWLFOLLOW
			if Input.is_action_pressed("kickball") and Input.is_action_just_pressed("down"):
				state = CRAWLIDLE

			if Input.is_action_just_pressed("simplefollow"):
				state = CRAWLFOLLOW
			if Input.is_action_just_pressed("simplestandstill"):
				state = CRAWLIDLE

		CRAWLIDLE:
			compstateteller.play("stopstate")
			oxygenbar.hide()
			animatedsprite.animation = "Crawlidle"
			vel.x = 0
			direction.x = 0
			vel.x = direction.x * 0
			
			vel.y += gravity * delta
			gravity = 1450.0
			vel = move_and_slide_with_snap(vel, Vector2.DOWN, Vector2.UP)

			if is_on_floor() and not was_on_floor:
				audioplayer.play()
			was_on_floor = is_on_floor()

			if Input.is_action_pressed("kickball") and Input.is_action_just_pressed("right"):
				state = CRAWLFOLLOW
			if Input.is_action_pressed("kickball") and Input.is_action_just_pressed("left"):
				state = CRAWLRUN

			if Input.is_action_just_pressed("simplefollow"):
				state = CRAWLFOLLOW
			if Input.is_action_just_pressed("simplerunaway"):
				state = CRAWLRUN

		ICEFOLLOW:
			if Input.is_action_just_pressed("charnormal"):
				state = PLAYABLEICE
			compstateteller.play("followstate")
			oxygenbar.hide()
			$CompanionHurtbox/CollisionShape2D.shape.extents = Vector2(23, 82)
			$CompanionHurtbox/CollisionShape2D.position = Vector2(0, -81)
			$PortalCheck/CollisionShape2D.shape.extents = Vector2(23, 82)
			$PortalCheck/CollisionShape2D.position = Vector2(0, -81)
			$CollisionShape2D.shape.extents = Vector2(23, 82)
			$CollisionShape2D.position = Vector2(0, -81)

			pushcheck()
			var speedthing: int = 700
			var dirthing: int = 0
			if Player.global_position.x < global_position.x - 60:
				dirthing -= 1
				vel.x = lerp(vel.x, dirthing * speedthing, friction * acceleration)
			elif Player.global_position.x > global_position.x + 60:
				dirthing += 1
				vel.x = lerp(vel.x, dirthing * speedthing, friction * acceleration)
#			if dirthing != 0:
#				vel.x = lerp(vel.x, dirthing * speedthing, acceleration)
			elif dirthing == 0 and is_on_floor():
				vel.x = lerp(vel.x, 0, friction)
##				direction.x = 0
#			vel.x = dirthing * 350

			vel.y += gravity * delta
			gravity = 1450.0
			vel = move_and_slide_with_snap(vel, Vector2.DOWN, Vector2.UP)

			if is_on_floor() and not was_on_floor:
				audioplayer.play()
			was_on_floor = is_on_floor()

			if dirthing == 1 and is_on_floor():
				animatedsprite.animation = "Running"
				animatedsprite.flip_h = false
				pushdetector.position = Vector2(53, 0)
			elif dirthing == -1 and is_on_floor():
				animatedsprite.animation = "Running"
				animatedsprite.flip_h = true
				pushdetector.position = Vector2(-52, 0)
			else:
				animatedsprite.animation = "Iceslide"

			if is_on_floor() and Input.is_action_just_pressed("interactcomp"):
				vel.y = -JUMP_SPEED
				if vel.y < 0:
					vel.y += 500

			if vel.y < 0 and not is_on_floor():
				if ouch == false:
					animatedsprite.animation = "Jumpgoesup"
				elif ouch == true:
					animatedsprite.animation = "Hurt"
				if dirthing == 1:
					animatedsprite.flip_h = false
				elif dirthing == -1:
					animatedsprite.flip_h = true
			elif vel.y > 0 and not is_on_floor():
				if ouch == false:
					animatedsprite.animation = "Jumpgoesdown"
				elif ouch == true:
					animatedsprite.animation = "Hurt"
				if dirthing == 1:
					animatedsprite.flip_h = false
				elif dirthing == -1:
					animatedsprite.flip_h = true

			if Input.is_action_pressed("kickball") and Input.is_action_just_pressed("left"):
				state = ICERUN
			if Input.is_action_pressed("kickball") and Input.is_action_just_pressed("down"):
				state = ICEIDLE
			if is_on_water():
				Signals.emit_signal("touch_water")
				state = SWIMMING
			if is_on_ladder():
				if Input.is_action_just_pressed("interactcomp"):
					state = CLIMBIDLE
			if is_on_slow():
				state = SLOWFOLLOW
			if not is_on_ice():
				if is_on_floor():
					state = FOLLOWME
				else:
					pass

			if Input.is_action_just_pressed("simplestandstill"):
				state = ICEIDLE
			if Input.is_action_just_pressed("simplerunaway"):
				state = ICERUN


		ICERUN:
			if Input.is_action_just_pressed("charnormal"):
				state = PLAYABLEICE
			compstateteller.play("runstate")
			oxygenbar.hide()
			$CompanionHurtbox/CollisionShape2D.shape.extents = Vector2(23, 82)
			$CompanionHurtbox/CollisionShape2D.position = Vector2(0, -81)
			$PortalCheck/CollisionShape2D.shape.extents = Vector2(23, 82)
			$PortalCheck/CollisionShape2D.position = Vector2(0, -81)
			$CollisionShape2D.shape.extents = Vector2(23, 82)
			$CollisionShape2D.position = Vector2(0, -81)

			pushcheck()
			var speedthing: int = 700
			var dirthing: int = 0
			if Player.global_position.x < global_position.x - 10:
				dirthing += 1
				vel.x = lerp(vel.x, dirthing * speedthing, friction * acceleration)
			elif Player.global_position.x > global_position.x + 10:
				dirthing -= 1
				vel.x = lerp(vel.x, dirthing * speedthing, friction * acceleration)
#			if dirthing != 0:
#				vel.x = lerp(vel.x, dirthing * speedthing, acceleration)
			elif dirthing == 0 and is_on_floor():
				vel.x = lerp(vel.x, 0, friction)
##				direction.x = 0
#			vel.x = dirthing * 350

			vel.y += gravity * delta
			gravity = 1450.0
			vel = move_and_slide_with_snap(vel, Vector2.DOWN, Vector2.UP)

			if is_on_floor() and not was_on_floor:
				audioplayer.play()
			was_on_floor = is_on_floor()

			if dirthing == 1 and is_on_floor():
				animatedsprite.animation = "Running"
				animatedsprite.flip_h = false
				pushdetector.position = Vector2(53, 0)
			elif dirthing == -1 and is_on_floor():
				animatedsprite.animation = "Running"
				animatedsprite.flip_h = true
				pushdetector.position = Vector2(-52, 0)
			else:
				animatedsprite.animation = "Iceslide"

			if vel.y < 0 and not is_on_floor():
				if ouch == false:
					animatedsprite.animation = "Jumpgoesup"
				elif ouch == true:
					animatedsprite.animation = "Hurt"
				if dirthing == 1:
					animatedsprite.flip_h = false
				elif dirthing == -1:
					animatedsprite.flip_h = true
			elif vel.y > 0 and not is_on_floor():
				if ouch == false:
					animatedsprite.animation = "Jumpgoesdown"
				elif ouch == true:
					animatedsprite.animation = "Hurt"
				if dirthing == 1:
					animatedsprite.flip_h = false
				elif dirthing == -1:
					animatedsprite.flip_h = true

			if is_on_floor() and Input.is_action_just_pressed("interactcomp"):
				vel.y = -JUMP_SPEED
				if vel.y < 0:
					vel.y += 500

			if Input.is_action_pressed("kickball") and Input.is_action_just_pressed("right"):
				state = ICEFOLLOW
			if Input.is_action_pressed("kickball") and Input.is_action_just_pressed("down"):
				state = ICEIDLE
			if is_on_water():
				Signals.emit_signal("touch_water")
				state = SWIMRUN
			if is_on_ladder():
				if Input.is_action_just_pressed("interactcomp"):
					state = CLIMBIDLE
			if is_on_slow():
				state = SLOWRUN
			if not is_on_ice():
				if is_on_floor():
					state = RUNAWAY
				else:
					pass

			if Input.is_action_just_pressed("simplestandstill"):
				state = ICEIDLE
			if Input.is_action_just_pressed("simplefollow"):
				state = ICEFOLLOW

		ICEIDLE:
			if Input.is_action_just_pressed("charnormal"):
				state = PLAYABLEICE
			compstateteller.play("stopstate")
			oxygenbar.hide()
			$CompanionHurtbox/CollisionShape2D.shape.extents = Vector2(23, 82)
			$CompanionHurtbox/CollisionShape2D.position = Vector2(0, -81)
			$PortalCheck/CollisionShape2D.shape.extents = Vector2(23, 82)
			$PortalCheck/CollisionShape2D.position = Vector2(0, -81)
			$CollisionShape2D.shape.extents = Vector2(23, 82)
			$CollisionShape2D.position = Vector2(0, -81)

			animatedsprite.animation = "Iceslide"
			var speedthing: int = 700
			var dirthing: int = 0
			pushcheck()
			if dirthing == -1:
				vel.x = lerp(vel.x, dirthing * speedthing, acceleration)
				dirthing = 0
				if is_on_floor():
					dirthing = 0
					vel.x = lerp(vel.x, -60, friction * acceleration)
			if dirthing == 1:
				vel.x = lerp(vel.x, dirthing * speedthing, acceleration)
				dirthing = 0
				if is_on_floor():
					dirthing = 0
					vel.x = lerp(vel.x, 60, friction * acceleration)
			elif dirthing == 0 and is_on_floor():
				vel.x = lerp(vel.x, 0, friction * acceleration)
#			vel.x = 0
#			direction.x = 0
#			vel.x = direction.x * 0

			if vel.y < 0 and not is_on_floor():
				if ouch == false:
					animatedsprite.animation = "Jumpgoesup"
				elif ouch == true:
					animatedsprite.animation = "Hurt"
				if direction.x == 1:
					animatedsprite.flip_h = false
				elif direction.x == -1:
					animatedsprite.flip_h = true
			elif vel.y > 0 and not is_on_floor():
				if ouch == false:
					animatedsprite.animation = "Jumpgoesdown"
				elif ouch == true:
					animatedsprite.animation = "Hurt"
				if direction.x == 1:
					animatedsprite.flip_h = false
				elif direction.x == -1:
					animatedsprite.flip_h = true

			if is_on_floor() and Input.is_action_just_pressed("interactcomp"):
				vel.y = -JUMP_SPEED
				if vel.y < 0:
					vel.y += 500

			vel.y += gravity * delta
			gravity = 1450.0
			vel = move_and_slide_with_snap(vel, Vector2.DOWN, Vector2.UP)

			if is_on_floor() and not was_on_floor:
				audioplayer.play()
			was_on_floor = is_on_floor()

			if Input.is_action_pressed("kickball") and Input.is_action_just_pressed("right"):
				state = ICEFOLLOW
			if Input.is_action_pressed("kickball") and Input.is_action_just_pressed("left"):
				state = ICERUN
			if is_on_water():
				Signals.emit_signal("touch_water")
				state = SWIMIDLE
			if is_on_ladder():
				if Input.is_action_just_pressed("interactcomp"):
					state = CLIMBIDLE
			if not is_on_ice():
				if is_on_floor():
					state = STANDSTILL

			if Input.is_action_just_pressed("simplerunaway"):
				state = ICERUN
			if Input.is_action_just_pressed("simplefollow"):
				state = ICEFOLLOW

		DEATH:
			if is_on_water():
				animatedsprite.animation = "Drown"
			elif not is_on_water():
				animatedsprite.animation = "Dead"
			vel.x = 0
			vel.y += gravity * delta
			vel = move_and_slide_with_snap(vel, Vector2.DOWN, Vector2.UP)
			CompanionHurtbox.set_monitoring(false)
			yield(get_tree().create_timer(0.4), "timeout")
			$AnimationPlayer.stop(true)
			hide()
			go_to_checkpoint()

		SADNESS:
			pass

		HURT:
			pass
#		HURTFOLLOW:
#			pass
#		HURTRUN:
#			pass
#		HURTIDLE:
#			pass

		PUSHFOLLOW:
			compstateteller.play("followstate")
			oxygenbar.hide()
			$CompanionHurtbox/CollisionShape2D.shape.extents = Vector2(23, 82)
			$CompanionHurtbox/CollisionShape2D.position = Vector2(0, -81)
			$PortalCheck/CollisionShape2D.shape.extents = Vector2(23, 82)
			$PortalCheck/CollisionShape2D.position = Vector2(0, -81)
			$CollisionShape2D.shape.extents = Vector2(23, 82)
			$CollisionShape2D.position = Vector2(0, -81)

			pushcheck()
			if Player.global_position.x < global_position.x - 10:
				vel.x = -WALK_MAX_SPEED
				direction.x = -1
			elif Player.global_position.x > global_position.x + 10:
				vel.x = WALK_MAX_SPEED
				direction.x = 1
			else:
				vel.x = 0
				direction.x = 0
			vel.x = direction.x * 550

			if direction.x == 1 and is_on_floor():
				animatedsprite.animation = "Pushing"
				animatedsprite.flip_h = false
				pushdetector.position = Vector2(53, 0)
			elif direction.x == -1 and is_on_floor():
				animatedsprite.animation = "Pushing"
				animatedsprite.flip_h = true
				pushdetector.position = Vector2(-52, 0)
			else:
				animatedsprite.animation = "Idle"

			vel.y += gravity * delta
			gravity = 1450.0
			vel = move_and_slide_with_snap(vel, Vector2.DOWN, Vector2.UP)

			if is_on_floor() and not was_on_floor:
				audioplayer.play()
			was_on_floor = is_on_floor()

			if is_on_floor() and Input.is_action_just_pressed("interactcomp"):
				vel.y = -JUMP_SPEED
				if vel.y < 0:
					vel.y += 500

			if vel.y < 0 and not is_on_floor():
				if ouch == false:
					animatedsprite.animation = "Jumpgoesup"
				elif ouch == true:
					animatedsprite.animation = "Hurt"
				if direction.x == 1:
					animatedsprite.flip_h = false
				elif direction.x == -1:
					animatedsprite.flip_h = true
			elif vel.y > 0 and not is_on_floor():
				if ouch == false:
					animatedsprite.animation = "Jumpgoesdown"
				elif ouch == true:
					animatedsprite.animation = "Hurt"
				if direction.x == 1:
					animatedsprite.flip_h = false
				elif direction.x == -1:
					animatedsprite.flip_h = true

			if Input.is_action_pressed("kickball") and Input.is_action_just_pressed("left"):
				state = RUNAWAY
			if Input.is_action_pressed("kickball") and Input.is_action_just_pressed("down"):
				state = STANDSTILL
			if is_on_water():
				Signals.emit_signal("touch_water")
				state = SWIMMING
			if is_on_ladder():
				if Input.is_action_just_pressed("interactcomp"):
					state = CLIMBIDLE
			if is_on_slow():
				state = SLOWFOLLOW
			if is_on_ice():
				state = ICEFOLLOW

			if Input.is_action_just_pressed("simplerunaway"):
				state = PUSHRUN
			if Input.is_action_just_pressed("simplestandstill"):
				state = STANDSTILL

		PUSHRUN:
			compstateteller.play("runstate")
			oxygenbar.hide()
			$CompanionHurtbox/CollisionShape2D.shape.extents = Vector2(23, 82)
			$CompanionHurtbox/CollisionShape2D.position = Vector2(0, -81)
			$PortalCheck/CollisionShape2D.shape.extents = Vector2(23, 82)
			$PortalCheck/CollisionShape2D.position = Vector2(0, -81)
			$CollisionShape2D.shape.extents = Vector2(23, 82)
			$CollisionShape2D.position = Vector2(0, -81)

			pushcheck()
			if Player.global_position.x < global_position.x - 10:
				vel.x = WALK_MAX_SPEED
				direction.x = 1
			elif Player.global_position.x > global_position.x + 10:
				vel.x = -WALK_MAX_SPEED
				direction.x = -1
			else:
				vel.x = 0
				direction.x = 0
			vel.x = direction.x * 550


			vel.y += gravity * delta
			gravity = 1450.0
			vel = move_and_slide_with_snap(vel, Vector2.DOWN, Vector2.UP)

			if is_on_floor() and not was_on_floor:
				audioplayer.play()
			was_on_floor = is_on_floor()

			if direction.x == 1 and is_on_floor():
				animatedsprite.animation = "Pushing"
				animatedsprite.flip_h = false
				pushdetector.position = Vector2(53, 0)
			elif direction.x == -1 and is_on_floor():
				animatedsprite.animation = "Pushing"
				animatedsprite.flip_h = true
				pushdetector.position = Vector2(-52, 0)
			else:
				animatedsprite.animation = "Idle"

			if is_on_floor() and Input.is_action_just_pressed("interactcomp"):
				vel.y = -JUMP_SPEED
				if vel.y < 0:
					vel.y += 500

			if vel.y < 0 and not is_on_floor():
				if ouch == false:
					animatedsprite.animation = "Jumpgoesup"
				elif ouch == true:
					animatedsprite.animation = "Hurt"
				if direction.x == 1:
					animatedsprite.flip_h = false
				elif direction.x == -1:
					animatedsprite.flip_h = true
			elif vel.y > 0 and not is_on_floor():
				if ouch == false:
					animatedsprite.animation = "Jumpgoesdown"
				elif ouch == true:
					animatedsprite.animation = "Hurt"
				if direction.x == 1:
					animatedsprite.flip_h = false
				elif direction.x == -1:
					animatedsprite.flip_h = true

			if Input.is_action_pressed("kickball") and Input.is_action_just_pressed("right"):
				state = FOLLOWME
			if Input.is_action_pressed("kickball") and Input.is_action_just_pressed("down"):
				state = STANDSTILL
			if is_on_water():
				Signals.emit_signal("touch_water")
				state = SWIMRUN
			if is_on_ladder():
				if Input.is_action_just_pressed("interactcomp"):
					state = CLIMBIDLE
			if is_on_slow():
				state = SLOWRUN
			if is_on_ice():
				state = ICERUN

			if Input.is_action_just_pressed("simplefollow"):
				state = PUSHFOLLOW
			if Input.is_action_just_pressed("simplestandstill"):
				state = STANDSTILL


		PLAYABLENORMAL:
			if Input.is_action_just_pressed("charswitch"):
				state = STANDSTILL

			oxygenbar.hide()
			$CompanionHurtbox/CollisionShape2D.shape.extents = Vector2(23, 82)
			$CompanionHurtbox/CollisionShape2D.position = Vector2(0, -81)
			$PortalCheck/CollisionShape2D.shape.extents = Vector2(23, 82)
			$PortalCheck/CollisionShape2D.position = Vector2(0, -81)
			$CollisionShape2D.shape.extents = Vector2(23, 82)
			$CollisionShape2D.position = Vector2(0, -81)
			
			pushcheck()
			if Input.get_action_strength("left"):
				vel.x = -WALK_MAX_SPEED
				direction.x = -1
			elif Input.get_action_strength("right"):
				vel.x = WALK_MAX_SPEED
				direction.x = 1
			else:
				vel.x = 0
				direction.x = 0
			vel.x = direction.x * 550

			if direction.x == 1 and is_on_floor():
				animatedsprite.animation = "Running"
				animatedsprite.flip_h = false
				pushdetector.position = Vector2(53, 0)
			elif direction.x == -1 and is_on_floor():
				animatedsprite.animation = "Running"
				animatedsprite.flip_h = true
				pushdetector.position = Vector2(-52, 0)
			else:
				animatedsprite.animation = "Idle"

			vel.y += gravity * delta
			gravity = 1450.0
			vel = move_and_slide_with_snap(vel, Vector2.DOWN, Vector2.UP)

			if is_on_floor() and Input.is_action_just_pressed("jumpup"):
				vel.y = -JUMP_SPEED
				if vel.y < 0:
					vel.y += 500

			if vel.y < 0 and not is_on_floor():
				if ouch == false:
					animatedsprite.animation = "Jumpgoesup"
				elif ouch == true:
					animatedsprite.animation = "Hurt"
				if direction.x == 1:
					animatedsprite.flip_h = false
				elif direction.x == -1:
					animatedsprite.flip_h = true
			elif vel.y > 0 and not is_on_floor():
				if ouch == false:
					animatedsprite.animation = "Jumpgoesdown"
				elif ouch == true:
					animatedsprite.animation = "Hurt"
				if direction.x == 1:
					animatedsprite.flip_h = false
				elif direction.x == -1:
					animatedsprite.flip_h = true

			if is_on_floor() and not was_on_floor:
				audioplayer.play()
			was_on_floor = is_on_floor()


			if is_on_water():
				Signals.emit_signal("touch_water")
				state = PLAYABLESWIM
			if is_on_ladder():
				if Input.is_action_just_pressed("jumpup"):
					state = PLAYABLECLIMB
			if is_on_slow():
				state = PLAYABLESLOW
			if is_on_ice():
				state = PLAYABLEICE



		PLAYABLECLIMB:
			if Input.get_action_strength("right"):
				vel.x = 350
				animatedsprite.animation = "Climbing"
				animatedsprite.flip_h = false

			elif Input.get_action_strength("left"):
				vel.x = -350
				animatedsprite.animation = "Climbing"
				animatedsprite.flip_h = true

			elif Input.get_action_strength("jumpup"):
				vel.y = -350
#				vel.x = 0
				animatedsprite.animation = "Climbing"
			elif Input.get_action_strength("down"):
				vel.y = 350
#				vel.x = 0
				animatedsprite.animation = "Climbing"

			else:
				animatedsprite.animation = "Climbidle"
				vel.x = 0
				direction.x = 0
				vel.y = 0
				direction.y = 0

#			vel.x = direction.x * 390
			vel = move_and_slide_with_snap(vel, Vector2.DOWN, Vector2.UP)

			if not is_on_ladder():
				state = PLAYABLENORMAL

			if Input.is_action_just_pressed("charswitch"):
				state = CLIMBIDLE

		PLAYABLEICE:
			if Input.is_action_just_pressed("charswitch"):
				state = ICEIDLE

			oxygenbar.hide()
			$CompanionHurtbox/CollisionShape2D.shape.extents = Vector2(23, 82)
			$CompanionHurtbox/CollisionShape2D.position = Vector2(0, -81)
			$PortalCheck/CollisionShape2D.shape.extents = Vector2(23, 82)
			$PortalCheck/CollisionShape2D.position = Vector2(0, -81)
			$CollisionShape2D.shape.extents = Vector2(23, 82)
			$CollisionShape2D.position = Vector2(0, -81)

			animatedsprite.animation = "Iceslide"
			var speedthing: int = 700
			var dirthing: int = 0
			pushcheck()
			if Input.get_action_strength("left"):
				dirthing -= 1
				vel.x = lerp(vel.x, dirthing * speedthing, friction * acceleration)
			elif Input.get_action_strength("right"):
				dirthing += 1
				vel.x = lerp(vel.x, dirthing * speedthing, friction * acceleration)

			else:
				if dirthing == 0 and is_on_floor():
					vel.x = lerp(vel.x, 0, friction)

			if dirthing == 1 and is_on_floor():
				animatedsprite.animation = "Running"
				animatedsprite.flip_h = false
				pushdetector.position = Vector2(53, 0)
			elif dirthing == -1 and is_on_floor():
				animatedsprite.animation = "Running"
				animatedsprite.flip_h = true
				pushdetector.position = Vector2(-52, 0)
			else:
				animatedsprite.animation = "Iceslide"


			if vel.y < 0 and not is_on_floor():
				if ouch == false:
					animatedsprite.animation = "Jumpgoesup"
				elif ouch == true:
					animatedsprite.animation = "Hurt"
				if direction.x == 1:
					animatedsprite.flip_h = false
				elif direction.x == -1:
					animatedsprite.flip_h = true
			elif vel.y > 0 and not is_on_floor():
				if ouch == false:
					animatedsprite.animation = "Jumpgoesdown"
				elif ouch == true:
					animatedsprite.animation = "Hurt"
				if direction.x == 1:
					animatedsprite.flip_h = false
				elif direction.x == -1:
					animatedsprite.flip_h = true

			if is_on_floor() and Input.is_action_just_pressed("jumpup"):
				vel.y = -JUMP_SPEED
				if vel.y < 0:
					vel.y += 500

			vel.y += gravity * delta
			gravity = 1450.0
			vel = move_and_slide_with_snap(vel, Vector2.DOWN, Vector2.UP)

			if is_on_floor() and not was_on_floor:
				audioplayer.play()
			was_on_floor = is_on_floor()

			if is_on_water():
				Signals.emit_signal("touch_water")
				state = PLAYABLESWIM
			if is_on_ladder():
				if Input.is_action_just_pressed("jumpup"):
					state = PLAYABLECLIMB
			if not is_on_ice():
				if is_on_floor():
					state = PLAYABLENORMAL


		PLAYABLESWIM:
			if Input.is_action_just_pressed("charswitch"):
				state = SWIMIDLE

			if immortal == false:
				oxygenbar.show()
				oxygen -= 1
			elif immortal == true:
				oxygenbar.hide()
				oxygen = 1500

			if Input.get_action_strength("right"):
				vel.x = 350
				vel.y = 0
				animatedsprite.animation = "Swimming"
				animatedsprite.flip_h = false
				pushdetector.position = Vector2(53, 0)
			elif Input.get_action_strength("left"):
				vel.x = -350
				vel.y = 0
				animatedsprite.animation = "Swimming"
				animatedsprite.flip_h = true
				pushdetector.position = Vector2(-52, 0)
			elif Input.get_action_strength("jumpup"):
				vel.y = -350
#				vel.x = 0
				animatedsprite.animation = "Swimup"
			elif Input.get_action_strength("down"):
				vel.y = 350
#				vel.x = 0
				animatedsprite.animation = "Swimdown"
			else:
				vel.x = 0
				direction.x = 0
				vel.x = direction.x * 0
				vel.y = 85
				direction.y = 0	
				animatedsprite.animation = "Swimidle"

			if not is_on_water():
				oxygen = 1500
				oxygenbar.hide()
				state = PLAYABLENORMAL
			vel = move_and_slide_with_snap(vel, Vector2.DOWN, Vector2.UP)
			direction = direction.normalized()
			vel = vel.normalized()
			vel.x = direction.x * 350
			vel.y = direction.y * 350



		PLAYABLECRAWL:
			pass

		PLAYABLEPUSH:
			pass

		PLAYABLESLOW:
			pass


func _on_CompanionHurtbox_area_entered(Area2D):
	if Area2D.name == "EnemyHitbox":
		ouch = true
		$AnimationPlayer.play("CompHurt")
		health -= 10
		vel.y -= 500
		yield(get_tree().create_timer(0.5), "timeout")
		ouch = false
	if Area2D.name == "DeathHitbox":
		health = 0

func is_invul():
	immortal = true
	print("does it work")
	$FloaterActive.show()
	CompanionHurtbox.set_monitoring(false)
	yield(get_tree().create_timer(30), "timeout")
	print("hope it did")
	CompanionHurtbox.set_monitoring(true)
	$FloaterActive.hide()
	immortal = false

func is_on_water():
	if not swimCheck.is_colliding(): return false
	var collider = swimCheck.get_collider()
	if not collider is Water: return false
	return true

func is_on_ladder():
	if not ladderCheck.is_colliding(): return false
	var collider = ladderCheck.get_collider()
	if not collider is Ladder: return false
	return true

func is_on_slow():
	if not slowCheck.is_colliding(): return false
	var collider = slowCheck.get_collider()
	if not collider is SlowFloor: return false
	return true

func is_on_ice():
	if not iceCheck.is_colliding(): return false
	var collider = iceCheck.get_collider()
	if not collider is IceFloor: return false
	return true

func pushcheck():
	for index in get_slide_count():
		var collision = get_slide_collision(index)
		if collision.collider is PushableCopy:
			collision.collider.slide(-collision.normal * (speed / 2.5) )
		else:
			return false
	return true

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


func _on_CrawlCheck_area_entered(area):
	if area.is_in_group("CrawlzoneEnter"):
		if state == FOLLOWME:
			state = CRAWLFOLLOW
			$CollisionShape2D.shape.extents = Vector2(68, 35)
			$CollisionShape2D.position = Vector2(0, -40)
			$CompanionHurtbox/CollisionShape2D.shape.extents = Vector2(68, 35)
			$CompanionHurtbox/CollisionShape2D.position = Vector2(0, -40)
			$PortalCheck/CollisionShape2D.shape.extents = Vector2(68, 35)
			$PortalCheck/CollisionShape2D.position = Vector2(0, -40)
		if state == STANDSTILL:
			state = CRAWLIDLE
			$CollisionShape2D.shape.extents = Vector2(68, 35)
			$CollisionShape2D.position = Vector2(0, -40)
			$CompanionHurtbox/CollisionShape2D.shape.extents = Vector2(68, 35)
			$CompanionHurtbox/CollisionShape2D.position = Vector2(0, -40)
			$PortalCheck/CollisionShape2D.shape.extents = Vector2(68, 35)
			$PortalCheck/CollisionShape2D.position = Vector2(0, -40)
		if state == RUNAWAY:
			state = CRAWLRUN
			$CollisionShape2D.shape.extents = Vector2(68, 35)
			$CollisionShape2D.position = Vector2(0, -40)
			$CompanionHurtbox/CollisionShape2D.shape.extents = Vector2(68, 35)
			$CompanionHurtbox/CollisionShape2D.position = Vector2(0, -40)
			$PortalCheck/CollisionShape2D.shape.extents = Vector2(68, 35)
			$PortalCheck/CollisionShape2D.position = Vector2(0, -40)

	if area.is_in_group("CrawlzoneExit"):
		if state == CRAWLFOLLOW:
			state = FOLLOWME
			$CompanionHurtbox/CollisionShape2D.shape.extents = Vector2(23, 82)
			$CompanionHurtbox/CollisionShape2D.position = Vector2(0, -81)
			$PortalCheck/CollisionShape2D.shape.extents = Vector2(23, 82)
			$PortalCheck/CollisionShape2D.position = Vector2(0, -81)
			$CollisionShape2D.shape.extents = Vector2(23, 82)
			$CollisionShape2D.position = Vector2(0, -81)
		if state == CRAWLIDLE:
			state = STANDSTILL
			$CompanionHurtbox/CollisionShape2D.shape.extents = Vector2(23, 82)
			$CompanionHurtbox/CollisionShape2D.position = Vector2(0, -81)
			$PortalCheck/CollisionShape2D.shape.extents = Vector2(23, 82)
			$PortalCheck/CollisionShape2D.position = Vector2(0, -81)
			$CollisionShape2D.shape.extents = Vector2(23, 82)
			$CollisionShape2D.position = Vector2(0, -81)
		if state == CRAWLRUN:
			state = RUNAWAY
			$CompanionHurtbox/CollisionShape2D.shape.extents = Vector2(23, 82)
			$CompanionHurtbox/CollisionShape2D.position = Vector2(0, -81)
			$PortalCheck/CollisionShape2D.shape.extents = Vector2(23, 82)
			$PortalCheck/CollisionShape2D.position = Vector2(0, -81)
			$CollisionShape2D.shape.extents = Vector2(23, 82)
			$CollisionShape2D.position = Vector2(0, -81)

func go_to_checkpoint():
	if Signals.lives > 0:
		var thing = checkpointTween.interpolate_property(self, "position", position, last_checkpoint.global_position, 1, Tween.TRANS_EXPO, Tween.EASE_OUT)
		thing = checkpointTween.start()
		state = STANDSTILL
		health = 50
		oxygen = 1500
		$CollisionShape2D.disabled = true
		yield(get_tree().create_timer(0.4), "timeout")
		$CollisionShape2D.disabled = false
		CompanionHurtbox.set_monitoring(true)
		show()
		animatedsprite.animation = "Jumpgoesdown"
		$AnimationPlayer.play("CompHurt")
	elif Signals.lives == 0:
		SceneManager.change_scene("level_transition_effect", "res://screens/GameOver.tscn")

func _on_PushDetector_area_entered(area):
	if area.name == "PushArea":
		if state == FOLLOWME:
			state = PUSHFOLLOW
		if state == RUNAWAY:
			state = PUSHRUN

func _on_PushDetector_area_exited(area):
	if area.name == "PushArea":
		if state == PUSHFOLLOW:
			state = FOLLOWME
		if state == PUSHRUN:
			state = RUNAWAY
