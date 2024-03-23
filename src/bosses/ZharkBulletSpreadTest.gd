extends KinematicBody2D


onready var gunhole = $Position2D
const Bullet = preload("res://src/bosses/VerticalBullet.tscn")


func _ready():
	Signals.connect("scene_has_changed", self, "therefore_I_Go")

func attack():
	var projectile = Bullet.instance()
	projectile.global_position = gunhole.global_position
	projectile.velocity.y = projectile.speed * 10
	get_tree().get_root().add_child(projectile)

func die():
	queue_free()

func therefore_I_Go():
	die()
