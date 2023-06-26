extends KinematicBody2D


var direction = Vector2.UP
var velocity = Vector2.ZERO
onready var sprite = $AnimatedSprite
onready var timer = $Timer
onready var spritetimer = $SpriteTimer
onready var mouth = $Position2D
onready var animation = $AnimationPlayer

#var PROJECTILE_VELOCITY = 1000
const Fireball = preload("res://src/enemies/FishProjectile.tscn")
const FireballLeft = preload("res://src/enemies/FishProjectileLeft.tscn")

var canattack = true

func _ready():
	animation.play("RESET")
	timer.start(1.5)
	sprite.animation = "closedmouth"

func _physics_process(delta):
	var hitceiling = is_on_ceiling()
	var hitfloor = is_on_floor()
	if hitfloor:
		direction *= -1
		sprite.flip_h = false
		mouth.position = Vector2( 0, 0)
	if hitceiling:
		direction *= -1
		sprite.flip_h = true
		mouth.position = Vector2( -240, 0)
	velocity = direction * 290
	move_and_slide(velocity, Vector2.UP)
	if timer.time_left == 0:
		if canattack == true:
			attack()
			timer.start(1.5)
		elif canattack == false:
			pass
	if spritetimer.time_left == 0:
		sprite.animation = "closedmouth"


func attack():
	if sprite.flip_h == false:
		var projectile = Fireball.instance()
		projectile.global_position = mouth.global_position
#		projectile.linear_velocity = Vector2(direction * PROJECTILE_VELOCITY, 0)
		get_tree().get_root().add_child(projectile)
	elif sprite.flip_h == true:
		var projectileleft = FireballLeft.instance()
		projectileleft.global_position = mouth.global_position
#		projectileleft.linear_velocity = Vector2(direction * PROJECTILE_VELOCITY, 0)
		get_tree().get_root().add_child(projectileleft)
	sprite.animation = "openmouth"
	spritetimer.start(0.5)

func die():
	queue_free()

func _on_FishHurtbox_area_entered(area):
	if area.name == "PlayerMelee":
		animation.play("dying")
		canattack = false
	if area.name == "EnemyCrusher":
		animation.play("dying")
		canattack = false

func _on_FishHurtbox_body_entered(body):
	if body.name == "SoccerBall":
		animation.play("dying")
		canattack = false
