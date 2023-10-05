extends KinematicBody2D

var direction = Vector2.RIGHT
var velocity = Vector2.ZERO
var knockback_dir = 1

onready var sprite = $AnimatedSprite
onready var timer = $Timer
onready var spritetimer = $SpriteTimer
onready var animation = $AnimationPlayer

var canattack = true

enum {
	ALIVE,
	DEAD
}

var state = ALIVE

func _ready():
	animation.play("RESET")
	timer.start(1.5)
	sprite.animation = "closedmouth"

func _physics_process(delta):
	match state:
		ALIVE:
			var found_wall = is_on_wall()
			if found_wall:
				direction *= -1
			velocity = direction * 290
			move_and_slide(velocity, Vector2.UP)
			if timer.time_left == 0:
				if canattack == true:
					attack()
					timer.start(1.5)
				elif canattack == false:
					pass
			if spritetimer.time_left == 0:
				sprite.animation = "closedmouth"
		DEAD:
			velocity = 0


func attack():
	sprite.animation = "openmouth"
	spritetimer.start(0.5)

func die():
	queue_free()
