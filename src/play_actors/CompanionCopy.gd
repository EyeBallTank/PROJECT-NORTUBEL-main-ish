extends KinematicBody2D

const FLOOR_NORMAL: = Vector2.UP

export var speed: = Vector2(300.0, 1000.0)
export var gravity: = 3000.0
export var health : int = 50
#export var oxygen : int = 70
export (float, 0, 1.0) var friction = 0.1
export (float, 0, 1.0) var acceleration = 0.25

var velocity: = Vector2.ZERO
var direction = Vector2.ZERO

#I took Gonkee's Jared AI code and tried to change it to my preferences.
#And the state machine was based on a suggestion by TebyTheCat on Newgrounds.

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

onready var Player = get_parent().get_node("Player")
onready var healthBar = $HealthbarCompanion

var vel = Vector2(0, 0)
var STOP_FORCE = 450

var grav = 1800
var max_grav = 3000

var react_time = 400
var dir = 0
var next_dir = 0
var next_dir_time = 0

var next_jump_time = -1

var target_player_distance = 90



onready var swimCheck = $swimCheck
onready var ladderCheck = $ladderCheck
onready var hurtbox = $HurtboxComp
onready var slowCheck = $SlowCheck

var portal_id = 0

func _ready():
	set_process(true)
	healthBar.max_value = health


func set_dir(target_dir):
	if next_dir != target_dir:
		next_dir = target_dir
		next_dir_time = Time.get_ticks_msec() + react_time

func get_hurted():
	$AnimationPlayer.play("companionhurt")
	health -= 10
	vel.y -= 500


func _process(delta):
	healthBar.value = health
	if health <= 0:
		queue_free()

	match state:
		FOLLOWME:
			react_time = 400
			vel.y += grav * delta;
			if vel.y > max_grav:
				vel.y = max_grav
			grav = 1800
			max_grav = 3000
			
			pushcheck()

			if is_on_ladder():
				if Input.is_action_just_pressed("interactcomp"):
					state = CLIMBMOVE

			if Player.position.x < position.x - target_player_distance and sees_player():
				set_dir(-1)
			elif Player.position.x > position.x + target_player_distance and sees_player():
				set_dir(1)
			else:
				set_dir(0)

			if Time.get_ticks_msec() > next_dir_time:
				dir = next_dir
#
			if Time.get_ticks_msec() > next_jump_time and next_jump_time != -1 and is_on_floor():
				if Player.position.y < position.y - 64:
					vel.y = -800
				next_jump_time = -1
	
			if Player.position.y < position.y - 64 and next_jump_time == -1:
				next_jump_time = react_time
			
			if Input.is_action_pressed("standstill"):
				state = STANDSTILL

			if Input.is_action_pressed("runaway"):
				state = RUNAWAY

			if is_on_water():
				state = SWIMMING
			
			if is_on_slow():
				state = SLOWFOLLOW


		STANDSTILL:
			vel.y += grav * delta;
			if vel.y > max_grav:
				vel.y = max_grav
			grav = 1800
			max_grav = 3000
			
			pushcheck()
			if is_on_ladder():
				if Input.is_action_just_pressed("interactcomp"):
					state = CLIMBIDLE
			set_dir(0)
			vel.x = 0
			target_player_distance = 0
			next_dir = 0
			next_dir_time = 0
			dir = 0
			
			
			if Input.is_action_pressed("followme"):
				state = FOLLOWME

			if is_on_water():
				state = SWIMIDLE

			if Input.is_action_pressed("runaway"):
				state = RUNAWAY

			
		SWIMMING:
			
			if Player.position.x < position.x - target_player_distance:
				if Player.position.y < position.y - target_player_distance:
						set_dir(-1)
#						vel.y = -800
						vel = position.direction_to(Player.position) * speed
						
				elif Player.position.y > position.y + target_player_distance:
						set_dir(-1)
#						vel.y = 800
						vel = position.direction_to(Player.position) * speed

			elif Player.position.x > position.x + target_player_distance:
				if Player.position.y < position.y - target_player_distance:
						set_dir(1)
#						vel.y = -800
						vel = position.direction_to(Player.position) * speed
				elif Player.position.y > position.y + target_player_distance:
						set_dir(1)
#						vel.y = 800
						vel = position.direction_to(Player.position) * speed

			else:
				set_dir(0)
				vel.y = 0

			if Time.get_ticks_msec() > next_dir_time:
				dir = next_dir

			if Input.is_action_pressed("standstill"):
				state = SWIMIDLE
				
			if Input.is_action_pressed("runaway"):
				state = SWIMRUN

			if not is_on_water():
				state = FOLLOWME
				
			vel.y += grav * delta;
			if vel.y > max_grav:
				vel.y = max_grav
			
		SWIMIDLE:
			set_dir(0)
			vel.x = 0
			target_player_distance = 0
			next_dir = 0
			next_dir_time = 0
			dir = 0
			vel.y = 0
			
			if Input.is_action_pressed("followme"):
				state = SWIMMING
			if Input.is_action_pressed("runaway"):
				state = SWIMRUN

			if not is_on_water():
				state = STANDSTILL
				
			vel.y += grav * delta;
			if vel.y > max_grav:
				vel.y = max_grav
		RUNAWAY:
			react_time = 250
			vel.y += grav * delta;
			if vel.y > max_grav:
				vel.y = max_grav
			grav = 1800
			max_grav = 3000
			pushcheck()
			if is_on_ladder():
				if Input.is_action_just_pressed("interactcomp"):
					state = CLIMBRUN

			if Player.position.x < position.x - target_player_distance:
				set_dir(1)
			elif Player.position.x > position.x + target_player_distance:
				set_dir(-1)
			else:
				set_dir(0)

			if Time.get_ticks_msec() > next_dir_time:
				dir = next_dir

			if Input.is_action_pressed("standstill"):
				state = STANDSTILL

			if Input.is_action_pressed("followme"):
				state = FOLLOWME

			if is_on_water():
				state = SWIMRUN

			if is_on_slow():
				state = SLOWRUN

		SWIMRUN:
			if Player.position.x < position.x - target_player_distance:
				if Player.position.y < position.y - target_player_distance:
						set_dir(1)
#						vel.y = 800
						vel = position.direction_to(Player.position) * -speed
						
				elif Player.position.y > position.y + target_player_distance:
						set_dir(1)
#						vel.y = -800
						vel = position.direction_to(Player.position) * -speed

			elif Player.position.x > position.x + target_player_distance:
				if Player.position.y < position.y - target_player_distance:
						set_dir(-1)
#						vel.y = 800
						vel = position.direction_to(Player.position) * -speed
				elif Player.position.y > position.y + target_player_distance:
						set_dir(-1)
#						vel.y = -800
						vel = position.direction_to(Player.position) * -speed

			else:
				set_dir(0)
				vel.y = 0
				
			if Time.get_ticks_msec() > next_dir_time:
				dir = next_dir

			if Input.is_action_pressed("standstill"):
				state = SWIMIDLE
				
			if Input.is_action_pressed("followme"):
				state = SWIMMING
				
			if not is_on_water():
				state = RUNAWAY
				
			vel.y += grav * delta;
			if vel.y > max_grav:
				vel.y = max_grav
		CLIMBIDLE:
			set_dir(0)
			vel.x = 0
			target_player_distance = 0
			next_dir = 0
			next_dir_time = 0
			dir = 0
			vel.y = 0

			if Input.is_action_pressed("followme"):
				state = CLIMBMOVE
				
			if Input.is_action_pressed("runaway"):
				state = CLIMBRUN

			if Input.is_action_just_pressed("interactcomp"):
				state = STANDSTILL

			if not is_on_ladder():
				state = STANDSTILL
			grav = 0
			max_grav = 0

		CLIMBMOVE:
			if Player.position.y < position.y - target_player_distance:
					set_dir(1)
					vel = position.direction_to(Player.position) * speed
			elif Player.position.y > position.y + target_player_distance:
					set_dir(1)
					vel = position.direction_to(Player.position) * speed
			else:
				set_dir(0)
				vel.y = 0
				
			if Input.is_action_pressed("standstill"):
				state = CLIMBIDLE
			if Input.is_action_pressed("runaway"):
				state = CLIMBRUN
			if Input.is_action_just_pressed("interactcomp"):
				state = FOLLOWME
			if not is_on_ladder():
				state = FOLLOWME

			grav = 0
			max_grav = 0
		CLIMBRUN:
			if Player.position.y < position.y - target_player_distance:
				set_dir(1)
				vel = position.direction_to(Player.position) * -speed
			elif Player.position.y > position.y + target_player_distance:
				set_dir(1)
				vel = position.direction_to(Player.position) * -speed
			else:
				set_dir(0)
				vel.y = 0
				
			if Input.is_action_pressed("standstill"):
				state = CLIMBIDLE
			if Input.is_action_pressed("followme"):
				state = CLIMBMOVE
			if Input.is_action_just_pressed("interactcomp"):
				state = RUNAWAY
			if not is_on_ladder():
				state = RUNAWAY
				
			grav = 0
			max_grav = 0

		CRAWLIDLE:
			vel.y += grav * delta;
			if vel.y > max_grav:
				vel.y = max_grav
			grav = 1800
			max_grav = 3000


			set_dir(0)
			vel.x = 0
			target_player_distance = 0
			next_dir = 0
			next_dir_time = 0
			dir = 0

			if Input.is_action_pressed("runaway"):
				state = CRAWLRUN

			if Input.is_action_pressed("followme"):
				state = CRAWLFOLLOW

		CRAWLFOLLOW:
			
			vel.y += grav * delta;
			if vel.y > max_grav:
				vel.y = max_grav
			grav = 1800
			max_grav = 3000

			if Player.position.x < position.x - target_player_distance:
				set_dir(-1)
				
			elif Player.position.x > position.x + target_player_distance:
				set_dir(1)
				
			else:
				set_dir(0)

			if Time.get_ticks_msec() > next_dir_time:
				dir = next_dir

			if Input.is_action_pressed("standstill"):
				state = CRAWLIDLE
				
			if Input.is_action_pressed("runaway"):
				state = CRAWLRUN

		CRAWLRUN:
			vel.y += grav * delta;
			if vel.y > max_grav:
				vel.y = max_grav
			grav = 1800
			max_grav = 3000

			if Player.position.x < position.x - target_player_distance:
				set_dir(1)
				
			elif Player.position.x > position.x + target_player_distance:
				set_dir(-1)
				
			else:
				set_dir(0)

			if Time.get_ticks_msec() > next_dir_time:
				dir = next_dir

			if Input.is_action_pressed("standstill"):
				state = CRAWLIDLE

			if Input.is_action_pressed("followme"):
				state = CRAWLFOLLOW
				
		SLOWRUN:
			vel.y += grav * delta;
			if vel.y > max_grav:
				vel.y = max_grav
			grav = 1800
			max_grav = 3000
			pushcheck()
			if is_on_ladder():
				if Input.is_action_just_pressed("interactcomp"):
					state = CLIMBMOVE

			if Player.position.x < position.x - target_player_distance:
				set_dir(0.3)
			elif Player.position.x > position.x + target_player_distance:
				set_dir(-0.3)
			else:
				set_dir(0)

			if Time.get_ticks_msec() > next_dir_time:
				dir = next_dir

			if Input.is_action_pressed("standstill"):
				state = STANDSTILL

			if Input.is_action_pressed("followme"):
				state = SLOWFOLLOW

			if is_on_water():
				state = SWIMMING

			if not is_on_slow():
				state = RUNAWAY
			else:
				pass

		SLOWFOLLOW:
			react_time = 10
			vel.y += grav * delta;
			if vel.y > max_grav:
				vel.y = max_grav
			grav = 1800
			max_grav = 3000
			pushcheck()
			if is_on_ladder():
				if Input.is_action_just_pressed("interactcomp"):
					state = CLIMBRUN

			if Player.position.x < position.x - target_player_distance:
				set_dir(-0.3)
			elif Player.position.x > position.x + target_player_distance:
				set_dir(0.3)
			else:
				set_dir(0)

			if Time.get_ticks_msec() > next_dir_time:
				dir = next_dir

			if Input.is_action_pressed("standstill"):
				state = STANDSTILL

			if Input.is_action_pressed("runaway"):
				state = SLOWRUN

			if is_on_water():
				state = SWIMMING

			if not is_on_slow():
				state = FOLLOWME
			else:
				pass

	if is_on_floor() and vel.y > 0:
		vel.y = 0
		
	vel.x = dir * 500

	vel = move_and_slide(vel, Vector2(0, -1))

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

func _on_Hurtbox_area_entered(area):
	if area.is_in_group("enemies"):
		get_hurted()

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

func ice_check():
	for index in get_slide_count():
		var collision = get_slide_collision(index)
		if collision.collider is IceFloor:
			pass
		else:
			return false
	return true

func is_on_slow():
	if not slowCheck.is_colliding(): return false
	var collider = slowCheck.get_collider()
	if not collider is SlowFloor: return false
	return true

func _on_CrawlCheck_area_entered(area):
	if area.is_in_group("CrawlzoneEnter"):
		if state == FOLLOWME:
			state = CRAWLFOLLOW
			$CollisionShape2D.shape.extents = Vector2(68, 35)
			$CollisionShape2D.position = Vector2(0, -40)
			$HurtboxComp/CollisionShape2D.shape.extents = Vector2(68, 35)
			$HurtboxComp/CollisionShape2D.position = Vector2(0, -40)
			$PortalCheck/CollisionShape2D.shape.extents = Vector2(68, 35)
			$PortalCheck/CollisionShape2D.position = Vector2(0, -40)

		if state == RUNAWAY:
			state = CRAWLRUN
			$CollisionShape2D.shape.extents = Vector2(68, 35)
			$CollisionShape2D.position = Vector2(0, -40)
			$HurtboxComp/CollisionShape2D.shape.extents = Vector2(68, 35)
			$HurtboxComp/CollisionShape2D.position = Vector2(0, -40)
			$PortalCheck/CollisionShape2D.shape.extents = Vector2(68, 35)
			$PortalCheck/CollisionShape2D.position = Vector2(0, -40)

		if state == STANDSTILL:
			state = CRAWLIDLE
			$HurtboxComp/CollisionShape2D.shape.extents = Vector2(68, 35)
			$HurtboxComp/CollisionShape2D.position = Vector2(0, -40)
			$PortalCheck/CollisionShape2D.shape.extents = Vector2(68, 35)
			$PortalCheck/CollisionShape2D.position = Vector2(0, -40)
			$CollisionShape2D.shape.extents = Vector2(68, 35)
			$CollisionShape2D.position = Vector2(0, -40)


	if area.is_in_group("CrawlzoneExit"):
		if state == CRAWLFOLLOW:
			state = FOLLOWME
			$HurtboxComp/CollisionShape2D.shape.extents = Vector2(23, 81)
			$HurtboxComp/CollisionShape2D.position = Vector2(-1, -82)
			$PortalCheck/CollisionShape2D.shape.extents = Vector2(23, 81)
			$PortalCheck/CollisionShape2D.position = Vector2(-1, -82)
			$CollisionShape2D.shape.extents = Vector2(23, 81)
			$CollisionShape2D.position = Vector2(-1, -82)


		if state == CRAWLRUN:
			state = RUNAWAY
			$HurtboxComp/CollisionShape2D.shape.extents = Vector2(23, 81)
			$HurtboxComp/CollisionShape2D.position = Vector2(-1, -82)
			$PortalCheck/CollisionShape2D.shape.extents = Vector2(23, 81)
			$PortalCheck/CollisionShape2D.position = Vector2(-1, -82)
			$CollisionShape2D.shape.extents = Vector2(23, 81)
			$CollisionShape2D.position = Vector2(-1, -82)


		if state == CRAWLIDLE:
			state = STANDSTILL
			$HurtboxComp/CollisionShape2D.shape.extents = Vector2(23, 81)
			$HurtboxComp/CollisionShape2D.position = Vector2(-1, -82)
			$PortalCheck/CollisionShape2D.shape.extents = Vector2(23, 81)
			$PortalCheck/CollisionShape2D.position = Vector2(-1, -82)
			$CollisionShape2D.shape.extents = Vector2(23, 81)
			$CollisionShape2D.position = Vector2(-1, -82)


func sees_player():
	var eye_reach = 10
	var vision = 10
	var eye_center = get_global_position()
	var eye_top = eye_center + Vector2(0, -eye_reach)
	var eye_left = eye_center + Vector2(-eye_reach, 0)
	var eye_right = eye_center + Vector2(eye_reach, 0)

	var player_pos = Player.get_global_position()
	var player_extents = Player.get_node("CollisionShape2D").shape.extents - Vector2(1, 1)
	var top_left = player_pos + Vector2(-player_extents.x, -player_extents.y)
	var top_right = player_pos + Vector2(player_extents.x, -player_extents.y)
	var bottom_left = player_pos + Vector2(-player_extents.x, player_extents.y)
	var bottom_right = player_pos + Vector2(player_extents.x, player_extents.y)

	var space_state = get_world_2d().direct_space_state

	for eye in [eye_center, eye_top, eye_left, eye_right]:
		for corner in [top_left, top_right, bottom_left, bottom_right]:
			if (corner - eye).length() > vision:
				continue
			var collision = space_state.intersect_ray(eye, corner, [], 1) # collision mask = sum of 2^(collision layers) - e.g 2^0 + 2^3 = 9
			if collision and collision.collider.name == "Player":
				return false
	return true
