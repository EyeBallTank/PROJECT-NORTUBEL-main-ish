extends KinematicBody2D

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

var state = FOLLOWME

var WALK_FORCE = 1600
var WALK_MAX_SPEED = 70
var PUSH_SPEED = 150
var STOP_FORCE = 450
var JUMP_SPEED = 1450

export var gravity: = 1450.0
#export var oxygen : int = 70
export (float, 0, 1.0) var friction = 0.1
export (float, 0, 1.0) var acceleration = 0.25

var velocity: = Vector2.ZERO
var direction: = Vector2.ZERO
onready var Player = get_parent().get_node("Player")

onready var healthBar = $HealthbarCompanion
export var health : int = 50
onready var CompanionHurtbox = $CompanionHurtbox

func _ready():
	healthBar.max_value = health

func get_hurted():
	$AnimationPlayer.play("CompHurt")
	health -= 10
	velocity.y -= 500

func _physics_process(delta):
	healthBar.value = health
	if health <= 0:
		queue_free()

	match state:
		FOLLOWME:
			if Player.global_position.x < global_position.x - 10:
				velocity.x = WALK_MAX_SPEED
				direction.x = -1
			elif Player.global_position.x > global_position.x + 10:
				velocity.x = -WALK_MAX_SPEED
				direction.x = 1
			else:
				velocity.x = 0
				direction.x = 0
			velocity.x = direction.x * 550
	
	
			velocity.y += gravity * delta
			velocity = move_and_slide_with_snap(velocity, Vector2.DOWN, Vector2.UP)
	
			if is_on_floor() and Player.global_position.y < global_position.y - 10:
				velocity.y = -JUMP_SPEED
				if velocity.y < 0:
					velocity.y += 500

			if Input.is_action_pressed("runaway"):
				state = RUNAWAY
			if Input.is_action_pressed("standstill"):
				state = STANDSTILL

		STANDSTILL:
			velocity.x = 0
			direction.x = 0
			velocity.x = direction.x * 0
			
			velocity.y += gravity * delta
			velocity = move_and_slide_with_snap(velocity, Vector2.DOWN, Vector2.UP)
			
			if Input.is_action_pressed("followme"):
				state = FOLLOWME

			if Input.is_action_pressed("runaway"):
				state = RUNAWAY

		RUNAWAY:
			if Player.global_position.x < global_position.x - 10:
				velocity.x = WALK_MAX_SPEED
				direction.x = 1
			elif Player.global_position.x > global_position.x + 10:
				velocity.x = -WALK_MAX_SPEED
				direction.x = -1
			else:
				velocity.x = 0
				direction.x = 0
			velocity.x = direction.x * 550
	
	
			velocity.y += gravity * delta
			velocity = move_and_slide_with_snap(velocity, Vector2.DOWN, Vector2.UP)
	
			if is_on_floor() and Player.global_position.y < global_position.y - 10:
				velocity.y = -JUMP_SPEED
				if velocity.y < 0:
					velocity.y += 500

			if Input.is_action_pressed("followme"):
				state = FOLLOWME
			if Input.is_action_pressed("standstill"):
				state = STANDSTILL

func _on_CompanionHurtbox_area_entered(Area2D):
	if Area2D.name == "EnemyHitbox":
		get_hurted()
