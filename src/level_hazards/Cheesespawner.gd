extends KinematicBody2D

onready var timer = $Timer
onready var mouth = $Position2D

const Fireball = preload("res://src/level_hazards/CheeseRoll.tscn")


func _ready():
	timer.start(4)

func _physics_process(delta):
	if timer.time_left == 0:
		attack()
		timer.start(4)
		
func attack():
	var projectile = Fireball.instance()
	projectile.global_position = mouth.global_position
	get_tree().get_root().add_child(projectile)
