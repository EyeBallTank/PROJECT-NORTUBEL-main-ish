extends Node2D

onready var conveyerfloor = $ConveyerFloor
onready var crate_one = $Crate1
onready var crate_two = $Crate2
onready var crate_three = $Crate3
onready var create_four = $Crate4

onready var animation = $AnimationPlayer

func _ready():
	animation.set_speed_scale(2.3)
#	pass # Replace with function body.


func _physics_process(delta):
	conveyerfloor.constant_linear_velocity = Vector2(155, 0)
