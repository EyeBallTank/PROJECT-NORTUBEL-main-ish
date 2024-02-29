extends KinematicBody2D

var velocity = Vector2.ZERO
var direction = Vector2.LEFT
var speed = 200
onready var animation = $AnimationPlayer
#the sprite should flip properly but oh well
func _ready():
	animation.play("RESET")
	Signals.connect("scene_has_changed", self, "therefore_I_Go")

func _physics_process(delta):
	move_and_slide(velocity, Vector2.UP)
	if is_on_wall():
		animation.play("Dying")

func die():
	queue_free()

func therefore_I_Go():
	die()

func _on_Touchplayer_body_entered(body):
	if body.is_in_group("protagonists"):
		animation.play("Dying")


func _on_Hurtbox_area_entered(area):
	if area.name == "PlayerMelee":
		animation.play("Dying")
