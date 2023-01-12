extends RigidBody2D
class_name Pushable

func _integrate_forces(state: Physics2DDirectBodyState) -> void:
	angular_velocity = 0
	rotation_degrees = 0

func _ready():
	pass
