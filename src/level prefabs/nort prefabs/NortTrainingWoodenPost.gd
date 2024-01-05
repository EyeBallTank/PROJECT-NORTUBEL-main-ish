extends KinematicBody2D
#in real life this is called a Mu ren zhuang
onready var sprite = $AnimatedSprite

func _ready():
	sprite.play("default")


func _on_hit_area_entered(area):
	if area.name == "PlayerMelee":
		sprite.play("hit")
