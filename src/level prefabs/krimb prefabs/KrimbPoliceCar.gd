extends StaticBody2D

onready var sprite = $sprites
onready var animation = $AnimationPlayer

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	sprite.play("default")


func _on_takedamage_area_entered(area):
	if area.name == "PlayerMelee":
		sprite.play("broken")
		animation.play("playsound")
