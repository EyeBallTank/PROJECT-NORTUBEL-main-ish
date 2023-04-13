extends Area2D
class_name IceFloor
tool

#With ice tiles, add an extra square to their size if there's a cliff
#This is so characters can maintain their icy physics when falling off an icy platform

onready var collisionshape = $CollisionShape2D
export var collision_newsize = Vector2()


func _ready():
	self.scale = collision_newsize
	pass
