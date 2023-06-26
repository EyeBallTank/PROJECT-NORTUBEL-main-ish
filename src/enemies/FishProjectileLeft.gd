extends KinematicBody2D

#ONLY EXISTS OUT OF DESPERATION
#BETTER USE SOME TUTORIALS FOR NEXT NEW ENEMIES LOL

var velocity = Vector2.ZERO
var direction = Vector2.RIGHT
var speed = 25
onready var animation = $AnimationPlayer

func _ready():
	animation.play("RESET")

func _physics_process(delta):
	rotation_degrees += -7
	if is_on_wall():
		animation.play("dying")
	velocity.x = speed * -10
	move_and_slide(velocity, Vector2.UP)

func die():
	queue_free()
