extends KinematicBody2D

onready var mouth = $Position2D

const Fireball = preload("res://src/level_hazards/herrko/ArrowTrapProjectile.tscn")

func _ready():
	Signals.connect("arrow_button_active", self, "_shoots_an_arrow")
	Signals.connect("arrow_button_unactive", self, "_doesnt_shoot_an_arrow")

func _shoots_an_arrow():
	attack()

func attack():
	var projectile = Fireball.instance()
	projectile.global_position = mouth.global_position
	get_tree().get_root().add_child(projectile)
#ACCORDING TO GODOT, THE LINE ABOVE CAUSES LIKE 5 ARROWS AND I DON'T GET WHY
#IT'S SUPPOSED TO BE COPIED FROM THE CHEESE SPAWNER SCENE'S CODE
	projectile.velocity.x = projectile.speed * -10

func _doesnt_shoot_an_arrow():
	pass
