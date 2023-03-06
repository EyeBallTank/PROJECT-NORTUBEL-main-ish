extends KinematicBody2D


const FLOOR_NORMAL: = Vector2.UP


export var speed: = Vector2(300.0, 1000.0)
export var gravity: = 3000.0
export var health : int = 50
export (float, 0, 1.0) var friction = 0.1
export (float, 0, 1.0) var acceleration = 0.25

var velocity: = Vector2.ZERO

#I took Gonkee's Jared AI code and tried to change it to my preferences.
#And the state machine was based on a suggestion by TebyTheCat on Newgrounds.

enum {
	FOLLOWME,
	STANDSTILL
#	CRAWL,
#	CLIMBIDLE,
#	CLIMBMOVE
#	PUSHFOLLOW
#	PUSHRUN
#	DEATH
#	SLOW
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
onready var hurtbox = $HurtboxComp

func _ready():
	set_process(true)
	healthBar.max_value = health


func set_dir(target_dir):
	if next_dir != target_dir:
		next_dir = target_dir
		next_dir_time = OS.get_ticks_msec() + react_time

func get_hurted():
	$AnimationPlayer.play("companionhurt")
	health -= 10
	vel.y -= 500


func _process(delta):
	healthBar.value = health
	if health <= 0:
		queue_free()
#	for index in get_slide_count():
#		var collision = get_slide_collision(index)
#		if collision.collider.is_in_group("enemies"):
#			health -= 10
			

	match state:
		FOLLOWME:
			pushcheck()
			if Player.position.x < position.x - target_player_distance:
				set_dir(-1)
				
			elif Player.position.x > position.x + target_player_distance:
				set_dir(1)
				
			else:
				set_dir(0)

			if OS.get_ticks_msec() > next_dir_time:
				dir = next_dir
	
			if OS.get_ticks_msec() > next_jump_time and next_jump_time != -1 and is_on_floor():
				if Player.position.y < position.y - 64:
					vel.y = -800
				next_jump_time = -1
	
			if Player.position.y < position.y - 64 and next_jump_time == -1:
				next_jump_time = OS.get_ticks_msec() + react_time
			
			if Input.is_action_pressed("standstill"):
				state = STANDSTILL

			if Input.is_action_pressed("runaway"):
				state = RUNAWAY

			if is_on_water():
				state = SWIMMING

		STANDSTILL:
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
				vel.y = 100
				
			if OS.get_ticks_msec() > next_dir_time:
				dir = next_dir

			if Input.is_action_pressed("standstill"):
				state = SWIMIDLE
				
			if Input.is_action_pressed("runaway"):
				state = SWIMRUN

			if not is_on_water():
				state = FOLLOWME

		SWIMIDLE:
			set_dir(0)
			vel.x = 0
			target_player_distance = 0
			next_dir = 0
			next_dir_time = 0
			dir = 0
			vel.y = 100
			
			if Input.is_action_pressed("followme"):
				state = SWIMMING
			if Input.is_action_pressed("runaway"):
				state = SWIMRUN

			if not is_on_water():
				state = STANDSTILL

		RUNAWAY:
			pushcheck()
			if Player.position.x < position.x - target_player_distance:
				set_dir(1)
			elif Player.position.x > position.x + target_player_distance:
				set_dir(-1)
			else:
				set_dir(0)

			if OS.get_ticks_msec() > next_dir_time:
				dir = next_dir

			if Input.is_action_pressed("standstill"):
				state = STANDSTILL

			if Input.is_action_pressed("followme"):
				state = FOLLOWME

			if is_on_water():
				state = SWIMRUN

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
				vel.y = 100
				
			if OS.get_ticks_msec() > next_dir_time:
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

	if is_on_floor() and vel.y > 0:
		vel.y = 0
		
	vel.x = dir * 500

	vel = move_and_slide(vel, Vector2(0, -1))
		

func is_on_water():
	if not swimCheck.is_colliding(): return false
	var collider = swimCheck.get_collider()
	if not collider is Water: return false
	return true

func _on_Hurtbox_area_entered(area):
	if area.name == "EnemyHitbox":
		get_hurted()


func pushcheck():
	for index in get_slide_count():
		var collision = get_slide_collision(index)
		if collision.collider is PushableCopy:
			collision.collider.slide(-collision.normal * (speed / 2.5) )
		else:
			return false
	return true

func ice_check():
	for index in get_slide_count():
		var collision = get_slide_collision(index)
		if collision.collider is IceFloor:
			pass
		else:
			return false
	return true
