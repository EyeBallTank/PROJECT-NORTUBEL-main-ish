extends CanvasLayer


onready var animation = $AnimationPlayer
onready var thegun = $KinematicBody2D
onready var gunsprites = $KinematicBody2D/AnimatedSprite

onready var Zharkovil = get_parent().get_node("ZharkovilBoss")
#var comp_position
#var target_position
#export var speed = 120

func ready():
	animation.play("RESET")
	Signals.connect("turn_off_zhark_shield", self, "yiegour_shoots")

func yiegour_shoots():
	animation.play("firing")
