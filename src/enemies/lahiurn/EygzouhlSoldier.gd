extends KinematicBody2D

export var gravity: = 23600

var direction = Vector2.RIGHT
var velocity = Vector2.ZERO

onready var sprite: = $AnimatedSprite
onready var floordetect = $Floordetect
onready var eyes = $Eyes

onready var animation = $AnimationPlayer
onready var timer = $Timer
onready var gunhole = $Position2D
onready var floorhole = $FloorFireSpawnArea
var canattack = false
var canmove = true

const Bullet = preload("res://src/enemies/lahiurn/EygzouhlFire.tscn")
const FloorFire = preload("res://src/enemies/lahiurn/EygzouhlFloorFire.tscn")
const BulletLeft = preload("res://src/enemies/lahiurn/EygzouhlFireLeft.tscn")

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

			velocity.x = 0
			animation.play("Shoot")
			timer.start(3)
			if timer.time_left == 0:
				state = MOVING
			velocity.y += gravity * delta
			move_and_slide(velocity, Vector2.UP)

		DEAD:
			animation.play("Dying.")

func attack():



	if direction == Vector2.RIGHT:
		var fire_hurt = Bullet.instance()
		get_tree().get_root().add_child(fire_hurt)
		fire_hurt.global_position = gunhole.global_position
	elif direction == Vector2.LEFT:
		var fire_hurt_left = BulletLeft.instance()
		get_tree().get_root().add_child(fire_hurt_left)
		fire_hurt_left.global_position = gunhole.global_position

	timer.start(0.5)

func attackfloorfire():
	var floor_fire_hurt = FloorFire.instance()
	get_tree().get_root().add_child(floor_fire_hurt)
	floor_fire_hurt.global_position = floorhole.global_position
	timer.start(0.5)

func detect_turn_around():
	if not floordetect.is_colliding() and is_on_floor():
		direction *= -1
#		sprite.flip_h = direction.x < 0
		scale.x = -scale.x

func die():
	queue_free()

func see_to_attack():
	if not eyes.is_colliding(): return false
	var collider = eyes.get_collider()
	if not collider.is_in_group("protagonists"): return false
#	if not collider is StellaMain: return false
#	if not collider is Companion: return false
	return true

func return_to_move():
	state = MOVING


func _on_EnemyHurtbox_area_entered(area):
	if area.name == "PlayerMelee":
		state = DEAD
	if area.name == "EnemyCrusher":
		state = DEAD

