extends RigidBody2D
class_name Pushable

func _integrate_forces(state: Physics2DDirectBodyState) -> void:
	angular_velocity = 0
	rotation_degrees = 0

func _ready():
	#pass
	add_central_force(Vector2(0, 1000))

func _process(delta):
	apply_central_impulse(Vector2(0, 75))
