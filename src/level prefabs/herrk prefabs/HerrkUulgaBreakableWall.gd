extends StaticBody2D

onready var animation = $AnimationPlayer



func _ready():
	animation.play("RESET")


func die():
	queue_free()


func _on_Kiss_by_Uulga_area_entered(area):
	if area.is_in_group("uulgahurtsyou"):
		animation.play("wall destroyed")
