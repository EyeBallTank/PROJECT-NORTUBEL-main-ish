extends KinematicBody2D
class_name Companion

#This character is a replacement for CompanionCopy. The main goal is that it does not use OS.get_ticks_msec() or even Time.get_ticks_msec()
#So far there are 3 problems:
#1: Its hurtbox doesn't work
#2: The current SWIMMING state has terrible swimming movement; Besides the lack of proper "diagonal" movement, there are moments where if they're close enough and you press "STANDSTILL/S", they simply go up and jump to the water surface
#3: The current CLIMB states also have terrible climbing movement
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
#	ICE
#	ICEFOLLOW
#	ICERUN
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
var portal_id = 0

func _ready():
	healthBar.max_value = health

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

		SWIMMING:
			if Player:
				vel = position.direction_to(Player.position) * speed
			if Player.global_position.x < global_position.x - 90:
				if Player.global_position.y < global_position.y - 90:
					vel = position.direction_to(Player.position) * speed
					direction.x = -1
					direction.y = -1
				elif Player.global_position.y > global_position.y + 90:
					vel = position.direction_to(Player.position) * speed
					direction.x = -1
					direction.y = 1
			elif Player.global_position.x > global_position.x + 90:
				if Player.global_position.y < global_position.y - 90:
					vel = position.direction_to(Player.position) * speed
					direction.x = 1
					direction.y = -1
				elif Player.global_position.y > global_position.y + 90:
					vel = position.direction_to(Player.position) * speed
					direction.x = 1
					direction.y = 1
#			if Player.global_position.x < global_position.x - 50:
#				vel = position.direction_to(Player.position) * speed.x
#			elif Player.global_position.x > global_position.x + 50:
#				vel = position.direction_to(Player.position) * speed.x
#			elif Player.global_position.y < global_position.y - 50:
#				vel = position.direction_to(Player.position) * speed.y
#			elif Player.global_position.y > global_position.y + 50:
#				vel = position.direction_to(Player.position) * speed.y
			else:
				vel.x = 0
				direction.x = 0
			vel.x = direction.x * 450

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
			vel.y = 0
			direction.y = 0
			vel.y = direction.y * 450
			vel.y += gravity * delta
			gravity = 100.0
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
			pass

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
			$CompanionHurtbox/CollisionShape2D.shape.extents = Vector2(23, 81)
			$CompanionHurtbox/CollisionShape2D.position = Vector2(-1, -82)
			$PortalCheck/CollisionShape2D.shape.extents = Vector2(23, 81)
			$PortalCheck/CollisionShape2D.position = Vector2(-1, -82)
			$CollisionShape2D.shape.extents = Vector2(23, 81)
			$CollisionShape2D.position = Vector2(-1, -82)
		if state == CRAWLIDLE:
			state = STANDSTILL
			$CompanionHurtbox/CollisionShape2D.shape.extents = Vector2(23, 81)
			$CompanionHurtbox/CollisionShape2D.position = Vector2(-1, -82)
			$PortalCheck/CollisionShape2D.shape.extents = Vector2(23, 81)
			$PortalCheck/CollisionShape2D.position = Vector2(-1, -82)
			$CollisionShape2D.shape.extents = Vector2(23, 81)
			$CollisionShape2D.position = Vector2(-1, -82)
		if state == CRAWLRUN:
			state = RUNAWAY
			$CompanionHurtbox/CollisionShape2D.shape.extents = Vector2(23, 81)
			$CompanionHurtbox/CollisionShape2D.position = Vector2(-1, -82)
			$PortalCheck/CollisionShape2D.shape.extents = Vector2(23, 81)
			$PortalCheck/CollisionShape2D.position = Vector2(-1, -82)
			$CollisionShape2D.shape.extents = Vector2(23, 81)
			$CollisionShape2D.position = Vector2(-1, -82)
