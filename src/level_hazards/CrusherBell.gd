extends Node2D

enum {HOVER, FALL, LAND, RISE}

var state = HOVER

onready var start_position = global_position
onready var raycast = $RayCast2D

func _ready():
	pass
