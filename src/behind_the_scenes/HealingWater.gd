extends Area2D
class_name HealingWater
tool

onready var collisionshape = $CollisionShape2D
export var collision_newsize = Vector2()
onready var animation = $AnimationPlayer

func _ready():
	animation.play("poison")
#	collisionshape.shape.extents = collision_newsize
	self.scale = collision_newsize

func _physics_process(delta):
	pass

func not_anymore():
	animation.play("poison")

func _on_HealingWater_body_entered(body):
	if body.is_in_group("protagonists"):
		body.health += 3
		if body.health > 100:
			body.health = 100
