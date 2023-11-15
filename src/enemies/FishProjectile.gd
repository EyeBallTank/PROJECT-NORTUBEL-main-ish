extends KinematicBody2D

var velocity = Vector2.ZERO
var direction = Vector2.RIGHT
var speed = 25
#var spin_direction = Vector2.RIGHT
onready var animation = $AnimationPlayer

func _ready():
	animation.play("RESET")
	Signals.connect("scene_has_changed", self, "therefore_I_Go")

func _physics_process(delta):
#	rotation_degrees += 7
	if is_on_wall():
		animation.play("dying")
#	velocity.x = speed * 10
	move_and_slide(velocity, Vector2.UP)
#	rotation_degrees += velocity * delta * spin_direction

func die():
	queue_free()


func _on_TouchPlayer_body_entered(body):
	if body.is_in_group("protagonists"):
		animation.play("dying")

func therefore_I_Go():
	die()
