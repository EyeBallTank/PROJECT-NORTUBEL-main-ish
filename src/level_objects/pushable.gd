extends RigidBody2D
class_name Pushable

# export var weight

func _integrate_forces(state: Physics2DDirectBodyState) -> void:
	angular_velocity = 0
	rotation_degrees = 0

func _ready():
	#pass
	add_central_force(Vector2(0, 1000))

func _process(delta):
	apply_central_impulse(Vector2(0, 75))

#	if body.name == "Player":
#		body.velocity.y = -500
#		body.move_and_slide(body.velocity)
