extends Area2D
class_name lowgravity
tool

onready var collisionshape = $CollisionShape2D
export var collision_newsize = Vector2()

func _ready():
	self.scale = collision_newsize

#NOTE TO SELF: MAKE IT SO ONLY PLAYER GETS TO USE LOW GRAVITY

#
#func _on_LowGravity_body_entered(body):
#	if body.is_in_group("protagonists"):
#		body.gravity == 100
#
#
#func _on_LowGravity_body_exited(body):
#	pass # Replace with function body.
