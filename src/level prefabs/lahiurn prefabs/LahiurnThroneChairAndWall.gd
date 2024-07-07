extends Node2D

onready var chair = $TheChair
onready var wall = $BrickWall
onready var animation = $AnimationPlayer


func _ready():
	animation.play("RESET")


func _on_talkto_body_entered(body):
	if body.name == "Player":
		if body.hastradeitem == true:
			animation.play("activechair")
		else:
			pass
