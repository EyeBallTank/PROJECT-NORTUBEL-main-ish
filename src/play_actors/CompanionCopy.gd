extends KinematicBody2D


const FLOOR_NORMAL: = Vector2.UP


export var speed: = Vector2(300.0, 1000.0)
export var gravity: = 3000.0
export var health : int = 50
var velocity: = Vector2.ZERO

#I took Gonkee's Jared AI code and tried to change it to my preferences.
#And the state machine was based on a suggestion by TebyTheCat on Newgrounds.

enum {
	FOLLOWME,
	STANDSTILL
#	CRAWL,
#	CLIMBIDLE,
#	CLIMBMOVE
#	PUSH
#	DEATH
#	SWIMIDLE
#	SWIMMING
}

var state = STANDSTILL

onready var Player = get_parent().get_node("Player")
onready var healthBar = $HealthbarCompanion

var vel = Vector2(0, 0)

var grav = 1800
var max_grav = 3000

var react_time = 400
var dir = 0
var next_dir = 0
var next_dir_time = 0

var next_jump_time = -1

var target_player_distance = 90

onready var swimCheck = $swimCheck

func _ready():
	set_process(true)
	healthBar.max_value = health


func set_dir(target_dir):
	if next_dir != target_dir:
		next_dir = target_dir
		next_dir_time = OS.get_ticks_msec() + react_time

func get_hurted():
	health -= 10
	vel.y -= 500
	$AnimationPlayer.play("companionhurt")

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

#			if is_on_water():
#				state = SWIMMING

		STANDSTILL:
			set_dir(0)
			vel.x = 0
			target_player_distance = 0
			next_dir = 0
			next_dir_time = 0
			dir = 0
			
			if Input.is_action_pressed("followme"):
				state = FOLLOWME

#			if is_on_water():
#				state = SWIMIDLE

#		SWIMMING:
#			if not is_on_water():
#				state = FOLLOWME
#

#		SWIMIDLE:
#			if not is_on_water():
#				state = STANDSTILL

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
