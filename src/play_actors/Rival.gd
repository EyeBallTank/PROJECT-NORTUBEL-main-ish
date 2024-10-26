extends KinematicBody2D
const FLOOR_NORMAL: = Vector2.UP

#Soon
export var rivalskin = "res://assets/sprites/rival sprites/AltOscar.tres"
onready var animatedsprite = $AnimatedSprite

export var speed: = Vector2(300.0, 1000.0)
export var gravity: = 3000.0
export var somespeedvalue = 600


var velocity: = Vector2.ZERO

enum {
	RUN,
	CLIMB,
	PUSH,
	IDLE,
	SWIMRIGHT,
	SWIMUP
}

var state = RUN
var was_on_floor = true
var portal_id = 0

var WALK_FORCE = 1600
var WALK_MAX_SPEED = 700
var PUSH_SPEED = 150
var STOP_FORCE = 450
var JUMP_SPEED = 1500

onready var ladderCheck = $LadderCheck
onready var pushdetector = $PushDetector
onready var audioplayer = $AudioStreamPlayer
onready var floordetect = $Floordetect
onready var signdetect = $Signdetect
onready var signdetectclimb = $Signdetectclimb
onready var rundetect = $Rundetect
onready var swimrightdetect = $Swimrightdetect
onready var swimupdetect = $Swimupdetect


func _ready():
	animatedsprite.frames = load(rivalskin)
	pass

func _physics_process(delta):
	match state:
		RUN:
			pushcheck()
			detect_jump()
			
			WALK_MAX_SPEED = somespeedvalue
			velocity.x = WALK_MAX_SPEED
			pushdetector.position = Vector2(63, 0)
			animatedsprite.animation = "Running"
			animatedsprite.flip_h = false

			velocity.y += gravity * delta
			velocity = move_and_slide_with_snap(velocity, Vector2.DOWN, Vector2.UP)

			if velocity.y < 0 and not is_on_floor():
				animatedsprite.animation = "Jumpgoesup"
			elif velocity.y > 0 and not is_on_floor():
				animatedsprite.animation = "Jumpgoesdown"

			if is_on_floor() and not was_on_floor:
				audioplayer.play()
			was_on_floor = is_on_floor()

			if detect_signs():
				state = IDLE

			if detect_climb():
				state = CLIMB

		CLIMB:
			PUSH_SPEED = 350
			velocity.y = -PUSH_SPEED
			velocity.x = 0
			animatedsprite.animation = "Climbing"
			velocity = move_and_slide_with_snap(velocity, Vector2.DOWN, Vector2.UP)

			if detect_signs():
				state = IDLE

			if detect_run():
				state = RUN

		PUSH:
			pushcheck()
			detect_jump()
			
			WALK_MAX_SPEED = somespeedvalue
			velocity.x = WALK_MAX_SPEED
			pushdetector.position = Vector2(63, 0)
			animatedsprite.animation = "Pushing"
			animatedsprite.flip_h = false

			velocity.y += gravity * delta
			velocity = move_and_slide_with_snap(velocity, Vector2.DOWN, Vector2.UP)

			if velocity.y < 0 and not is_on_floor():
				animatedsprite.animation = "Jumpgoesup"
			elif velocity.y > 0 and not is_on_floor():
				animatedsprite.animation = "Jumpgoesdown"

			if is_on_floor() and not was_on_floor:
				audioplayer.play()
			was_on_floor = is_on_floor()

			if detect_signs():
				state = IDLE

			if detect_climb():
				state = CLIMB

		IDLE:
			velocity.x = 0
			velocity.y += gravity * delta
			velocity = move_and_slide_with_snap(velocity, Vector2.DOWN, Vector2.UP)
			animatedsprite.animation = "Idle"
			if velocity.y < 0 and not is_on_floor():
				animatedsprite.animation = "Jumpgoesup"
			elif velocity.y > 0 and not is_on_floor():
				animatedsprite.animation = "Jumpgoesdown"

			if is_on_floor() and not was_on_floor:
				audioplayer.play()
			was_on_floor = is_on_floor()

			if detect_run():
				state = RUN

		SWIMRIGHT:
			pass

			if detect_run():
				state = RUN

		SWIMUP:
			pass

			if detect_run():
				state = RUN

func pushcheck():
	for index in get_slide_count():
		var collision = get_slide_collision(index)
		if collision.collider is PushableCopy:
			collision.collider.slide(-collision.normal * (WALK_MAX_SPEED / 2) )
		else:
			return false
	return true

func detect_jump():
	if not floordetect.is_colliding() and is_on_floor():
		velocity.y = -JUMP_SPEED

func detect_signs():
	if not signdetect.is_colliding(): return false
	var collider = signdetect.get_collider()
	if not collider is RivalIdleSign: return false
	return true

func detect_climb():
	if not signdetectclimb.is_colliding(): return false
	var collider = signdetectclimb.get_collider()
	if not collider is RivalClimbSign: return false
	return true

func detect_run():
	if not rundetect.is_colliding(): return false
	var collider = rundetect.get_collider()
	if not collider is RivalRunSign: return false
	return true


func _on_PushDetector_area_entered(area):
	if area.name == "PushArea":
		if state == RUN:
			state = PUSH

func _on_PushDetector_area_exited(area):
	if area.name == "PushArea":
		if state == PUSH:
			state = RUN

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
