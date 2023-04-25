extends KinematicBody2D
class_name PushableCopy

const FLOOR_NORMAL: = Vector2.UP

export var speed: = Vector2(300.0, 1000.0)
export var gravity: = 3000.0
onready var audioplayer = $AudioStreamPlayer

var velocity: = Vector2.ZERO

var WALK_FORCE = 1600
var WALK_MAX_SPEED = 700
var STOP_FORCE = 900
var JUMP_SPEED = 1500

var player_lenght = 64
#var push_factor = 150

onready var pushableside = $leftandrightside

func _ready():
	pass

func _physics_process(delta):
#	print(velocity.x)
#	audioplayer.stop()
	velocity.x = move_toward(velocity.x, 0, STOP_FORCE * delta)
#	velocity.x = 0
	velocity.y += gravity * delta
	velocity = move_and_slide_with_snap(velocity, Vector2.DOWN, Vector2.UP)
#	velocity = move_and_slide(velocity)
#	velocity = Vector2.ZERO
	if velocity.x > 0:
		audioplayer.play()
	elif velocity.x < 0:
		audioplayer.play()
	elif velocity.x == 0:
		audioplayer.stop()


#The sound does not loop in the way i wanted to
#Worse, the sound plays EVEN when the object's not being pushed
func slide(vector):
	velocity.x = vector.x
#	if velocity.x > 0:
#		audioplayer.play()
#	elif velocity.x < 0:
#		audioplayer.play()
#	elif velocity.x == 0:
#		audioplayer.stop()

#func _on_PushArea_area_entered(area):
#	if area.is_in_group("PushDetector"):
#		if velocity.x > 0:
#			audioplayer.play()
#		elif velocity.x < 0:
#			audioplayer.play()
#		elif velocity.x == 0:
#			audioplayer.stop()
#
#func _on_PushArea_area_exited(area):
#	if area.is_in_group("PushDetector"):
#		audioplayer.stop()
