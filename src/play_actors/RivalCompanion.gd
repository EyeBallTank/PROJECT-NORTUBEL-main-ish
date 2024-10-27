extends KinematicBody2D



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
var JUMP_SPEED = 1450

export var speed: = Vector2(300.0, 1000.0)
export var gravity: = 1450.0

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
			pass
		CLIMB:
			pass
		PUSH:
			pass
		SWIMRIGHT:
			pass
		SWIMUP:
			pass
		CRAWL:
			pass
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
