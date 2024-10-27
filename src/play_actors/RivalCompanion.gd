extends KinematicBody2D


onready var animatedsprite = $AnimatedSprite
onready var ladderCheck = $LadderCheck
onready var pushdetector = $PushDetector
onready var audioplayer = $AudioStreamPlayer
onready var floordetect = $Floordetect
onready var signdetect = $Signdetect
onready var signdetectclimb = $Signdetectclimb
onready var rundetect = $Rundetect
onready var swimrightdetect = $Swimrightdetect
onready var swimupdetect = $Swimupdetect
onready var crawldetect = $Crawldetect

var climbspeed = 360

var WALK_FORCE = 1600
var WALK_MAX_SPEED = 70
var PUSH_SPEED = 25
var STOP_FORCE = 450
var JUMP_SPEED = 650

export var speed: = Vector2(300.0, 1000.0)
export var gravity: = 1450.0
export var somespeedvalue = 530

var vel: = Vector2.ZERO
var direction: = Vector2.ZERO

var was_on_floor = true
var portal_id = 0
var state = RUN

enum {
	RUN,
	CLIMB,
	PUSH,
	IDLE,
	SWIMRIGHT,
	SWIMUP,
	CRAWL
}

func _ready():
	pass

func _physics_process(delta):
	match state:
		RUN:
			pushcheck()
			detect_jump()
			vel.x = WALK_MAX_SPEED
			direction.x = 1
			WALK_MAX_SPEED = somespeedvalue
			animatedsprite.animation = "Running"
			animatedsprite.flip_h = false

			vel.y += gravity * delta
			gravity = 650
			vel = move_and_slide_with_snap(vel, Vector2.DOWN, Vector2.UP)

			if vel.y < 0 and not is_on_floor():
				animatedsprite.animation = "Jumpgoesup"
			elif vel.y > 0 and not is_on_floor():
				animatedsprite.animation = "Jumpgoesdown"

			if is_on_floor() and not was_on_floor:
				audioplayer.play()
			was_on_floor = is_on_floor()

			if detect_signs():
				state = IDLE

			if detect_climb():
				state = CLIMB

			if detect_swim_up():
				state = SWIMUP
				Signals.emit_signal("touch_water")

			if detect_swim_right():
				state = SWIMRIGHT
				Signals.emit_signal("touch_water")

			if detect_crawl():
				state = CRAWL

		CLIMB:
			vel.y = -350
			vel.x = 0
			animatedsprite.animation = "Climbing"
			vel = move_and_slide_with_snap(vel, Vector2.DOWN, Vector2.UP)

			if detect_signs():
				state = IDLE

			if detect_run():
				state = RUN

		PUSH:
			pushcheck()
			detect_jump()

			vel.x = WALK_MAX_SPEED
			direction.x = 1
			WALK_MAX_SPEED = somespeedvalue
			animatedsprite.animation = "Pushing"
			animatedsprite.flip_h = false

			vel.y += gravity * delta
			gravity = 650
			vel = move_and_slide_with_snap(vel, Vector2.DOWN, Vector2.UP)

			if vel.y < 0 and not is_on_floor():
				animatedsprite.animation = "Jumpgoesup"
			elif vel.y > 0 and not is_on_floor():
				animatedsprite.animation = "Jumpgoesdown"

			if is_on_floor() and not was_on_floor:
				audioplayer.play()
			was_on_floor = is_on_floor()


			if detect_signs():
				state = IDLE

			if detect_climb():
				state = CLIMB

		SWIMRIGHT:
			vel.x = 350
			vel.y = 0
			animatedsprite.animation = "Swimming"
			animatedsprite.flip_h = false
			vel = move_and_slide_with_snap(vel, Vector2.DOWN, Vector2.UP)
			if detect_run():
				state = RUN

			if detect_swim_up():
				state = SWIMUP
		SWIMUP:

			vel.y = -350
			vel.x = 0
			animatedsprite.animation = "Swimup"
			vel = move_and_slide_with_snap(vel, Vector2.DOWN, Vector2.UP)
			if detect_run():
				state = RUN

			if detect_swim_right():
				state = SWIMRIGHT
		CRAWL:
			vel.x = WALK_MAX_SPEED
			direction.x = 1
			animatedsprite.animation = "Crawlling"
			animatedsprite.flip_h = false

			if detect_run():
				state = RUN
			vel.x = direction.x * 350

			if is_on_floor() and not was_on_floor:
				audioplayer.play()
			was_on_floor = is_on_floor()
			vel.y += gravity * delta
			gravity = 1450.0
			vel = move_and_slide_with_snap(vel, Vector2.DOWN, Vector2.UP)

		IDLE:
			pass

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
		vel.y = -JUMP_SPEED

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

func detect_swim_right():
	if not swimrightdetect.is_colliding(): return false
	var collider = swimrightdetect.get_collider()
	if not collider is RivalSwimRightSign: return false
	return true

func detect_swim_up():
	if not swimupdetect.is_colliding(): return false
	var collider = swimupdetect.get_collider()
	if not collider is RivalSwimUpSign: return false
	return true

func detect_crawl():
	if not crawldetect.is_colliding(): return false
	var collider = crawldetect.get_collider()
	if not collider is RivalCrawlSign: return false
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


func _on_PushDetector_area_entered(area):
	if area.name == "PushArea":
		if state == RUN:
			state = PUSH

func _on_PushDetector_area_exited(area):
	if area.name == "PushArea":
		if state == PUSH:
			state = RUN
