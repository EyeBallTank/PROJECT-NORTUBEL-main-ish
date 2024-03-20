extends KinematicBody2D

var velocity = Vector2.ZERO
var direction = Vector2.RIGHT
var speed = 25
#var spin_direction = Vector2.RIGHT
onready var animation = $AnimationPlayer
onready var elecplace = $Position2D

const Electricity = preload("res://src/enemies/greklovick/GrekSplittingEnergyOrbs.tscn")


func _ready():
	animation.play("RESET")
	Signals.connect("scene_has_changed", self, "therefore_I_Go")

func _physics_process(delta):
	if is_on_wall():
		animation.play("dying")
	move_and_slide(velocity, Vector2.UP)


func therefore_I_Go():
	die()

func die():
	queue_free()

func attack():
	var projectile = Electricity.instance()
	projectile.global_position = elecplace.global_position
	get_tree().get_root().add_child(projectile)
