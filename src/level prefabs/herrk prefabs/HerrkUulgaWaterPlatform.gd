extends Node2D

onready var animation = $AnimationPlayer


func _ready():
	Signals.connect("trade_item_received", self, "_water_uulga_platform_is_active")
	animation.play("RESET")

func _water_uulga_platform_is_active():
	animation.play("VerticalPlat")
