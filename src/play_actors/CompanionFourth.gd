extends KinematicBody2D
class_name Companion

#This character is a replacement for CompanionCopy. The main goal is that it does not use OS.get_ticks_msec() or even Time.get_ticks_msec()
#So far there are 2 problems:
#1: Its hurtbox doesn't work
#2: The current SWIMMING state has terrible swimming movement; Besides the lack of proper "diagonal" movement, there are moments where if they're close enough and you press "STANDSTILL/S", they simply go up and jump to the water surface
#I may need a lot of help to make this character.

enum {
	FOLLOWME,
	STANDSTILL,
	CRAWLIDLE,
	CRAWLFOLLOW,
	CRAWLRUN,
	CLIMBIDLE,
	CLIMBMOVE,
	CLIMBRUN,
#	PUSHFOLLOW
#	PUSHRUN
#	DEATH
	SLOWRUN,
	SLOWFOLLOW,
	ICEIDLE,
	ICEFOLLOW,
	ICERUN,
	SWIMIDLE,
	SWIMMING,
	SWIMRUN,
	RUNAWAY
}

var state = STANDSTILL

var WALK_FORCE = 1600
var WALK_MAX_SPEED = 70
var PUSH_SPEED = 25
var STOP_FORCE = 450
var JUMP_SPEED = 1450

export var speed: = Vector2(300.0, 1000.0)
export var gravity: = 1450.0
#export var oxygen : int = 70
export (float, 0, 1.0) var friction = 0.1
export (float, 0, 1.0) var acceleration = 0.25

var vel: = Vector2.ZERO
var direction: = Vector2.ZERO
onready var Player = get_parent().get_node("Player")

onready var healthBar = $HealthbarCompanion
export var health : int = 50
onready var CompanionHurtbox = $CompanionHurtbox
onready var swimCheck = $SwimCheck
onready var ladderCheck = $LadderCheck
onready var slowCheck = $SlowCheck
onready var iceCheck = $IceCheck
var portal_id = 0

var last_checkpoint: Area2D = null
onready var checkpointTween = $CheckpointTween

func _ready():
	healthBar.max_value = health
	var playerspawn = get_parent().get_node("playerspawn")
	last_checkpoint = playerspawn

func get_hurt():
	$AnimationPlayer.play("CompHurt")
	health -= 10
	vel.y -= 500

func _physics_process(delta):
	healthBar.value = health
	if health <= 0:
		queue_free()

	match state:
		FOLLOWME:
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

			vel.y += gravity * delta
			gravity = 1450.0
			vel = move_and_slide_with_snap(vel, Vector2.DOWN, Vector2.UP)

			if is_on_floor() and Player.global_position.y < global_position.y - 10:
				vel.y = -JUMP_SPEED
				if vel.y < 0:
					vel.y += 500

			if Input.is_action_pressed("runaway"):
				state = RUNAWAY
			if Input.is_action_pressed("standstill"):
				state = STANDSTILL
			if is_on_water():
				state = SWIMMING
			if is_on_ladder():
				if Input.is_action_just_pressed("interactcomp"):
					state = CLIMBIDLE
			if is_on_slow():
				state = SLOWFOLLOW
			if is_on_ice():
				state = ICEFOLLOW

		STANDSTILL:
			pushcheck()
			vel.x = 0
			direction.x = 0
			vel.x = direction.x * 0
			
			vel.y += gravity * delta
			gravity = 1450.0
			vel = move_and_slide_with_snap(vel, Vector2.DOWN, Vector2.UP)
			
			if Input.is_action_pressed("followme"):
				state = FOLLOWME
			if Input.is_action_pressed("runaway"):
				state = RUNAWAY
			if is_on_water():
				state = SWIMIDLE
			if is_on_ladder():
				if Input.is_action_just_pressed("interactcomp"):
					state = CLIMBIDLE
			if is_on_ice():
				state = ICEIDLE


		RUNAWAY:
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
	
			if is_on_floor() and Player.global_position.y < global_position.y - 10:
				vel.y = -JUMP_SPEED
				if vel.y < 0:
					vel.y += 500

			if Input.is_action_pressed("followme"):
				state = FOLLOWME
			if Input.is_action_pressed("standstill"):
				state = STANDSTILL
			if is_on_water():
				state = SWIMRUN
			if is_on_ladder():
				if Input.is_action_just_pressed("interactcomp"):
					state = CLIMBIDLE
			if is_on_slow():
				state = SLOWRUN
			if is_on_ice():
				state = ICERUN

		SWIMMING:
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
			if Player.global_position.x < global_position.x - 20:
				if Player.global_position.y < global_position.y - 20:
					vel = position.direction_to(Player.position) * speed.x
					vel = position.direction_to(Player.position) * speed.y
					direction.x = -1
					direction.y = -1
				elif Player.global_position.y > global_position.y + 20:
					vel = position.direction_to(Player.position) * speed.x
					vel = position.direction_to(Player.position) * speed.y
					direction.x = -1
					direction.y = 1
			elif Player.global_position.x > global_position.x + 20:
				if Player.global_position.y < global_position.y - 20:
					vel = position.direction_to(Player.position) * speed.x
					vel = position.direction_to(Player.position) * speed.y
					direction.x = 1
					direction.y = -1
				elif Player.global_position.y > global_position.y + 20:
					vel = position.direction_to(Player.position) * speed.x
					vel = position.direction_to(Player.position) * speed.y
					direction.x = 1
					direction.y = 1
			else:
				if Player.global_position.y < global_position.y - 20:
					vel = position.direction_to(Player.position) * speed.x
					vel = position.direction_to(Player.position) * speed.y
					direction.y = -1
				elif Player.global_position.y > global_position.y + 20:
					vel = position.direction_to(Player.position) * speed.x
					vel = position.direction_to(Player.position) * speed.y
					direction.y = 1
				else:
					vel.x = 0
					direction.x = 0
					vel.y = 0
					direction.y = 0
			direction = direction.normalized()
			vel.x = direction.x * 400
			vel.y = direction.y * 400

#			vel.y += gravity * delta
			vel = move_and_slide_with_snap(vel, Vector2.DOWN, Vector2.UP)

			if Input.is_action_pressed("runaway"):
				state = SWIMRUN
			if Input.is_action_pressed("standstill"):
				state = SWIMIDLE
			if not is_on_water():
				state = FOLLOWME

		SWIMRUN:
			pass
			

		SWIMIDLE:
			vel.x = 0
			direction.x = 0
			vel.x = direction.x * 0
#			vel.y = 0
#			direction.y = 0
#			vel.y = direction.y * 450
#			vel.y += gravity * delta
#			gravity = 10.0
			vel = move_and_slide_with_snap(vel, Vector2.DOWN, Vector2.UP)

			if Input.is_action_pressed("runaway"):
				state = SWIMRUN
			if Input.is_action_pressed("followme"):
				state = SWIMMING
			if not is_on_water():
				state = STANDSTILL

		CLIMBIDLE:
			vel.x = 0
			direction.x = 0
			vel.y = 0
			direction.y = 0

			if Input.is_action_pressed("followme"):
				state = CLIMBMOVE
			if Input.is_action_pressed("runaway"):
				state = CLIMBRUN
			if Input.is_action_just_pressed("interactcomp"):
				state = STANDSTILL
			if not is_on_ladder():
				state = STANDSTILL

		CLIMBMOVE:
#			if Player:
#				vel = position.direction_to(Player.position) * speed
			if Player.global_position.y < global_position.y - 30:
				vel = position.direction_to(Player.position) * speed
			elif Player.global_position.y > global_position.y + 30:
				vel = position.direction_to(Player.position) * speed
			else:
				vel.x = 0
				direction.x = 0
				vel.y = 0
				direction.y = 0
			vel.x = direction.x * 390
#Why do i have to use vel.x and not vel.y here?
			vel = move_and_slide_with_snap(vel, Vector2.DOWN, Vector2.UP)

			if Input.is_action_pressed("standstill"):
				state = CLIMBIDLE
			if Input.is_action_pressed("runaway"):
				state = CLIMBRUN
			if Input.is_action_just_pressed("interactcomp"):
				state = FOLLOWME
			if not is_on_ladder():
				state = FOLLOWME
		CLIMBRUN:
#			if Player:
#				vel = position.direction_to(Player.position) * speed
			if Player.global_position.y < global_position.y - 30:
				vel = position.direction_to(Player.position) * -speed
			elif Player.global_position.y > global_position.y + 30:
				vel = position.direction_to(Player.position) * -speed
			else:
				vel.x = 0
				direction.x = 0
				vel.y = 0
				direction.y = 0
			vel.x = direction.x * 390
#Why do i have to use vel.x and not vel.y here?
			vel = move_and_slide_with_snap(vel, Vector2.DOWN, Vector2.UP)

			if Input.is_action_pressed("standstill"):
				state = CLIMBIDLE
			if Input.is_action_pressed("followme"):
				state = CLIMBMOVE
			if Input.is_action_just_pressed("interactcomp"):
				state = RUNAWAY
			if not is_on_ladder():
				state = RUNAWAY

		SLOWFOLLOW:
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

			if is_on_floor() and Player.global_position.y < global_position.y - 10:
				vel.y = -JUMP_SPEED
				if vel.y < 0:
					vel.y += 500

			if Input.is_action_pressed("runaway"):
				state = SLOWRUN
			if Input.is_action_pressed("standstill"):
				state = STANDSTILL
			if is_on_water():
				state = SWIMMING
			if is_on_ladder():
				if Input.is_action_just_pressed("interactcomp"):
					state = CLIMBIDLE
			if not is_on_slow():
				if is_on_floor():
					state = FOLLOWME
		SLOWRUN:
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

			if is_on_floor() and Player.global_position.y < global_position.y - 10:
				vel.y = -JUMP_SPEED
				if vel.y < 0:
					vel.y += 500

			if Input.is_action_pressed("followme"):
				state = SLOWFOLLOW
			if Input.is_action_pressed("standstill"):
				state = STANDSTILL
			if is_on_water():
				state = SWIMRUN
			if is_on_ladder():
				if Input.is_action_just_pressed("interactcomp"):
					state = CLIMBIDLE
			if not is_on_slow():
				if is_on_floor():
					state = RUNAWAY

		CRAWLFOLLOW:
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

			vel.y += gravity * delta
			gravity = 1450.0
			vel = move_and_slide_with_snap(vel, Vector2.DOWN, Vector2.UP)

			if Input.is_action_pressed("runaway"):
				state = CRAWLRUN
			if Input.is_action_pressed("standstill"):
				state = CRAWLIDLE

		CRAWLRUN:
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

			if Input.is_action_pressed("followme"):
				state = CRAWLFOLLOW
			if Input.is_action_pressed("standstill"):
				state = CRAWLIDLE

		CRAWLIDLE:
			vel.x = 0
			direction.x = 0
			vel.x = direction.x * 0
			
			vel.y += gravity * delta
			gravity = 1450.0
			vel = move_and_slide_with_snap(vel, Vector2.DOWN, Vector2.UP)
			
			if Input.is_action_pressed("followme"):
				state = CRAWLFOLLOW
			if Input.is_action_pressed("runaway"):
				state = CRAWLRUN

		ICEFOLLOW:
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

			if is_on_floor() and Player.global_position.y < global_position.y - 10:
				vel.y = -JUMP_SPEED
				if vel.y < 0:
					vel.y += 500

			if Input.is_action_pressed("runaway"):
				state = ICERUN
			if Input.is_action_pressed("standstill"):
				state = ICEIDLE
			if is_on_water():
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

		ICERUN:
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

			if is_on_floor() and Player.global_position.y < global_position.y - 10:
				vel.y = -JUMP_SPEED
				if vel.y < 0:
					vel.y += 500

			if Input.is_action_pressed("followme"):
				state = ICEFOLLOW
			if Input.is_action_pressed("standstill"):
				state = ICEIDLE
			if is_on_water():
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

		ICEIDLE:
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
			
			vel.y += gravity * delta
			gravity = 1450.0
			vel = move_and_slide_with_snap(vel, Vector2.DOWN, Vector2.UP)
			
			if Input.is_action_pressed("followme"):
				state = ICEFOLLOW
			if Input.is_action_pressed("runaway"):
				state = ICERUN
			if is_on_water():
				state = SWIMIDLE
			if is_on_ladder():
				if Input.is_action_just_pressed("interactcomp"):
					state = CLIMBIDLE
			if not is_on_ice():
				if is_on_floor():
					state = STANDSTILL

func _on_CompanionHurtbox_area_entered(Area2D):
	if Area2D.name == "EnemyHitbox":
		get_hurt()

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
	var thing = checkpointTween.interpolate_property(self, "position", position, last_checkpoint.global_position, 1, Tween.TRANS_EXPO, Tween.EASE_OUT)
	thing = checkpointTween.start()
	state = STANDSTILL
	health = 100
