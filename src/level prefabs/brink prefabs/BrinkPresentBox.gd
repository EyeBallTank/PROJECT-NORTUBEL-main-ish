extends StaticBody2D

onready var sprite = $AnimatedSprite
onready var animation = $AnimationPlayer


func _ready():
	animation.play("RESET")



func _on_Area2D_area_entered(area):
	if area.name == "PlayerMelee":
		animation.play("opened")
