extends KinematicBody2D

var direction = Vector2.RIGHT
var velocity = Vector2.ZERO
var BALL_VELOCITY = 1200.0

onready var sprite: = $AnimatedSprite
onready var eyes = $Eyes
onready var animation = $AnimationPlayer
onready var timer = $Timer
onready var gunhole = $Position2D
var canattack = false
var canmove = true

const Bullet = preload("res://src/enemies/untotern/UntoDoubleFireballs.tscn")

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
			if see_to_attack():
				state = SHOOT
			sprite.play("move")
			var found_wall = is_on_wall()
			if found_wall:
				direction *= -1
				scale.x = -scale.x
			velocity = direction * 160
			move_and_slide(velocity, Vector2.UP)

		SHOOT:
			velocity.x = 0
			animation.play("Shoot")
			timer.start(2)
			if timer.time_left == 0:
				state = MOVING
			move_and_slide(velocity, Vector2.UP)

		DEAD:
			animation.play("Dying.")

func attack():
	var grenade = Bullet.instance()
	get_tree().get_root().add_child(grenade)
	grenade.global_position = gunhole.global_position

func die():
	queue_free()

func see_to_attack():
	if not eyes.is_colliding(): return false
	var collider = eyes.get_collider()
	if not collider.is_in_group("protagonists"): return false
	return true

func return_to_move():
	state = MOVING


func _on_EnemyHurtbox_area_entered(area):
	if area.name == "PlayerMelee":
		state = DEAD
	if area.name == "EnemyCrusher":
		state = DEAD
