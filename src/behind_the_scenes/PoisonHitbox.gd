extends Area2D
class_name Poison
tool

onready var collisionshape = $CollisionShape2D
export var collision_newsize = Vector2()
onready var animation = $AnimationPlayer

func _ready():
	Signals.connect("you_are_invincible", self, "_i_am_invincible")
	animation.play("poison")
#	collisionshape.shape.extents = collision_newsize
	self.scale = collision_newsize

func _physics_process(delta):
	pass

func _i_am_invincible():
	animation.play("RESET")

func not_anymore():
	animation.play("poison")


func _on_PoisonHitbox_body_entered(body):
	if body.is_in_group("protagonists"):
		body.health -= 1
