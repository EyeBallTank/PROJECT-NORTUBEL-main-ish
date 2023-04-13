extends Area2D
class_name Ladder
tool

#Pay attention to the code here, inspector settings of this scene
#And maybe the way how the stuff is positioned/scale in the editor in general
#I had to figure out how i could precisely scale the size of this scene accurately
#This is because Godot can be really inconsistent with collisions

#The context is that i wanted to find a way to make certain level scenes "versatile"
#First i wanted to make an export var out of their sizes
#Then i got rid of these scenes' sprites by making their visuals part of the Tilemap
#After trial and error, i finally found a method

#Look at the Collision Newsize settings and type "8 * number of tiles" and it mostly works
#Also, when you set the new size, try checking the scene you change and CTRL + S on its tab, when go
#Back to the level just to see the scene's new collisions, at least if you have "tool" in the script

onready var collisionshape = $CollisionShape2D
export var collision_newsize = Vector2()


func _ready():
#	collisionshape.shape.extents = collision_newsize
	self.scale = collision_newsize
	pass
