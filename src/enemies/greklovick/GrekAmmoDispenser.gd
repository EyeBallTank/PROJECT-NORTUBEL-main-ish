extends KinematicBody2D

export var gravity: = 23600

var direction = Vector2.RIGHT
var velocity = Vector2.ZERO
var BALL_VELOCITY = 1200.0

onready var sprite: = $AnimatedSprite
onready var floordetect = $Floordetect
onready var eyes = $Eyes
onready var animation = $AnimationPlayer
onready var timer = $Timer
onready var gunhole = $Position2D
onready var sound = $AudioStreamPlayer
var canattack = false
var canmove = true

const Bullet = preload("res://src/enemies/greklovick/GrekGrenade.tscn")

enum {
	MOVING,
	SHOOT,
	DEAD
}

var state = MOVING

func _ready():
	animation.play("RESET")

func _physics_process(delta):

	match state:
		MOVING:
			sound.set_volume_db(-80)
			if see_to_attack():
				state = SHOOT

			detect_turn_around()
			sprite.play("Running")
			var found_wall = is_on_wall()
			if found_wall:
				direction *= -1
				scale.x = -scale.x
			velocity = direction * 160
			velocity.y += gravity * delta
			move_and_slide(velocity, Vector2.UP)
			gravity = 37600


		SHOOT:
			sound.set_volume_db(-2.122) 
			velocity.x = 0
			animation.play("Shoot")
			timer.start(2)
			if timer.time_left == 0:
				state = MOVING
			velocity.y += gravity * delta
			move_and_slide(velocity, Vector2.UP)

		DEAD:
			sound.set_volume_db(-80)
			animation.play("Dying.")


func detect_turn_around():
	if not floordetect.is_colliding() and is_on_floor():
		direction *= -1
		scale.x = -scale.x

func die():
	queue_free()

func see_to_attack():
	if not eyes.is_colliding(): return false
	var collider = eyes.get_collider()
	if not collider.is_in_group("protagonists"): return false
	return true

func return_to_move():
	state = MOVING

func attack():
	sound.play()
	var bombdirect = scale.x
	var grenade = Bullet.instance()
	get_tree().get_root().add_child(grenade)
	grenade.global_position = gunhole.global_position
	grenade.linear_velocity = Vector2(direction.x * BALL_VELOCITY, 0)

	sprite.play("Attack")
	timer.start(0.5)


func _on_EnemyHurtbox_area_entered(area):
	if area.name == "PlayerMelee":
		state = DEAD
	if area.name == "EnemyCrusher":
		state = DEAD
