extends KinematicBody2D

export var gravity: = 23600
var direction = Vector2.RIGHT
var velocity = Vector2.ZERO
onready var timer = $Timer

onready var sprites = $AnimatedSprite

#

enum {
	STARTPLACE,
	FLYING,
	VICTORY,
	FALLING
}

var state = STARTPLACE
onready var start_position = global_position

func _ready():
	Signals.connect("bat_must_jump", self, "_the_bat_will_jump")
	Signals.connect("bat_must_really_jump", self, "_the_bat_will_really_jump")
#	var batspawn = get_parent().get_node("UntoBatGameBatStart")
	

func _physics_process(delta):

	match state:
		STARTPLACE:
			sprites.play("stop")
			global_position = start_position
			velocity.x = 0

		FLYING:
			sprites.play("flying")
			velocity = direction * 160
			velocity.y += gravity * delta
			move_and_slide(velocity, Vector2.UP)

		FALLING:
			
			sprites.play("flying")
			velocity = direction * 160
			velocity.y -= gravity * delta
			move_and_slide(velocity, Vector2.UP)
#			timer.start()
#			if timer.time_left == 0:
#				state = FLYING

		VICTORY:
			sprites.play("stop")
			velocity.x = 0

func jump():
	velocity.y = - 600

func _the_bat_will_jump():
	if state == STARTPLACE:
		state = FLYING

	if state == FLYING:
		pass



	if state == VICTORY:
		pass

func _the_bat_will_really_jump():
	if state == STARTPLACE:
		pass

	if state == VICTORY:
		pass

	if state == FLYING:
		state == FALLING

func _on_BatTouches_area_entered(area):
	if area.is_in_group("THEBATWON"):
		state = VICTORY


func _on_BatTouches_body_entered(body):
	if body.is_in_group("THEBATLOST"):
		state = STARTPLACE
