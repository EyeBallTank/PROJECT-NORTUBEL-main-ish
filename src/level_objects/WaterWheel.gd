extends Node2D
#onready var mainwheel = $KinematicBody2D
onready var woodenplat = $KinematicBody2D/Woodplat1
onready var animationplayer = $AnimationPlayer

func _ready():
	animationplayer.play("rotate")

func _physics_process(delta):
	woodenplat.global_rotation = 0
