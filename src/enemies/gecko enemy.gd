extends KinematicBody2D

var direction = Vector2.RIGHT
var velocity = Vector2.ZERO
onready var sprite: = $Sprite

func _physics_process(delta):
	var found_wall = is_on_wall()
	if found_wall:
		direction *= -1
		sprite.flip_v = direction.x > 0
		#using flip V instead of H because of the angle of the placeholder sprite
		#if i give the Gecko proper sprites, this will change
	velocity = direction * 290
	move_and_slide(velocity, Vector2.UP)
