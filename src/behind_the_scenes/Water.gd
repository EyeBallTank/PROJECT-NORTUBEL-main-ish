extends Area2D
class_name Water
tool

#water's collision should be 2 "squares" under its tiles or something due to collision weirdness
#maybe this issue is more on the characters but still

onready var collisionshape = $CollisionShape2D
export var collision_newsize = Vector2()


func _ready():
	self.scale = collision_newsize
	pass
