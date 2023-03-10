extends RigidBody2D
class_name FishHook

func _ready():
	pass

func _process(delta):
	if Input.is_action_pressed("right"):
		apply_central_impulse(Vector2(1000, 0))

	if Input.is_action_pressed("left"):
		apply_central_impulse(Vector2(-1000, 0))
