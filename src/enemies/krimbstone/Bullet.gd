extends KinematicBody2D

var velocity = Vector2.ZERO
var direction = Vector2.LEFT
var speed = 255
onready var animation = $AnimationPlayer

func _ready():
	animation.play("RESET")
	Signals.connect("scene_has_changed", self, "therefore_I_Go")

func die():
	queue_free()

func therefore_I_Go():
	die()

func _physics_process(delta):
#	velocity.x = speed
	move_and_slide(velocity, Vector2.UP)
	if is_on_wall():
		animation.play("Dying")

func _on_Touchplayer_body_entered(body):
	if body.is_in_group("protagonists"):
		animation.play("Dying")
