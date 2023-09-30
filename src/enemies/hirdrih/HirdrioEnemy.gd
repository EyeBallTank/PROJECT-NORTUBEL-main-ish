extends KinematicBody2D

var velocity = Vector2(200, 200)


func _ready():
	pass

func _physics_process(delta):

	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
		velocity = velocity.bounce(collision_info.normal)
