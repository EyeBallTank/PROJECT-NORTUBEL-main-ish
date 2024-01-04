extends KinematicBody2D

onready var sprite = $AnimatedSprite

func _ready():
	sprite.play("default")


func _on_hit_area_entered(area):
	if area.name == "PlayerMelee":
		sprite.play("hit")
