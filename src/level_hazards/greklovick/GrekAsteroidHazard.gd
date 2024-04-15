extends Node2D

onready var sprite = $Asteroid/GrekAsteroid


func _ready():
	pass 

func _physics_process(delta):
	sprite.rotation_degrees += 8
