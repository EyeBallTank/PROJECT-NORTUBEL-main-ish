extends Node2D
#THIS IDEA COULD BE BETTER
onready var eyes = $eyes
export var speed = 500
var comp_position
var target_position
onready var companion = get_parent().get_node("Player")


func _ready():
	pass 

func _physics_process(delta):
	comp_position = companion.position
	target_position = (comp_position - position).normalized()

	if position.distance_to(comp_position) > 3:
		eyes.move_and_slide(target_position * speed)
