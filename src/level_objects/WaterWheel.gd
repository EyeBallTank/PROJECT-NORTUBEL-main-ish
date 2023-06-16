extends Node2D
#onready var mainwheel = $KinematicBody2D
onready var woodenplat1 = $KinematicBody2D/Woodplat1
onready var woodenplat2 = $KinematicBody2D/Woodplat2
onready var woodenplat3 = $KinematicBody2D/Woodplat3
onready var woodenplat4 = $KinematicBody2D/Woodplat4

onready var animationplayer = $AnimationPlayer

func _ready():
	animationplayer.play("rotate")

func _physics_process(delta):
	woodenplat1.global_rotation_degrees = 0
	woodenplat2.global_rotation_degrees = 0
	woodenplat3.global_rotation_degrees = 0
	woodenplat4.global_rotation_degrees = 0
