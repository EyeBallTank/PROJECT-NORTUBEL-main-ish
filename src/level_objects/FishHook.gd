extends RigidBody2D
class_name FishHook

var vel = Vector2.ZERO
var hasplayer = false

func _ready():
	pass

func _physics_process(delta):
	if hasplayer == true:
		if Input.is_action_just_pressed("right"):
			apply_central_impulse(Vector2(800, 0))
			
	if hasplayer == true:
		if Input.is_action_just_pressed("left"):
			apply_central_impulse(Vector2(-800, 0))


func _on_DetectableRope_body_entered(body):
	if body.name == "Player":
		hasplayer = true

func _on_DetectableRope_body_exited(body):
	if body.name == "Player":
		hasplayer = false
