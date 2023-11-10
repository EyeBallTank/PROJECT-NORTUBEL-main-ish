extends KinematicBody2D

export var gravity: = 29600

var direction = Vector2.RIGHT
var velocity = Vector2.ZERO
var knockback_dir = 1
onready var sprite: = $AnimatedSprite
onready var floordetect = $Floordetect

enum {
	MOVING,
	SHOOT,
	DEAD
}

var state = MOVING

func _ready():
	pass

func _physics_process(delta):
	match state:
		MOVING:
			detect_turn_around()
			sprite.play("Running")
			var found_wall = is_on_wall()
			if found_wall:
				direction *= -1
				sprite.flip_h = direction.x < 0
				#using flip V instead of H because of the angle of the placeholder sprite
				#if i give the Gecko proper sprites, this will change
			velocity = direction * 160
			velocity.y += gravity * delta
			move_and_slide(velocity, Vector2.UP)



func detect_turn_around():
	if not floordetect.is_colliding() and is_on_floor():
		direction *= -1
		sprite.flip_h = direction.x < 0

func die():
	queue_free()
