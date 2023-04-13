extends StaticBody2D
tool

onready var collisionshape = $CollisionShape2D
export var collision_newsize = Vector2()


func _ready():
	self.scale = collision_newsize
	pass
