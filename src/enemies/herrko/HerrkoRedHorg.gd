extends KinematicBody2D

export var gravity: = 23600

var direction = Vector2.RIGHT
var velocity = Vector2.ZERO

onready var sprite: = $AnimatedSprite
onready var eyes = $RayCast2D
onready var animation = $AnimationPlayer
onready var timer = $Timer
onready var shockwavesource = $ShockwaveSource
onready var floordetect = $FloorDetect

const Bullet = preload("res://src/level_hazards/herrko/HorgShockwaveProjectile.tscn")

enum {
	MOVING,
	HAMMER,
	DEAD
}

var state = MOVING

func _ready():
	pass 

func _physics_process(delta):

	match state:
		MOVING:
			detect_turn_around()
			if see_to_attack():
				state = HAMMER

			sprite.play("moving")
			var found_wall = is_on_wall()
			if found_wall:
				direction *= -1
				scale.x = -scale.x
			velocity = direction * 160
			velocity.y += gravity * delta
			move_and_slide(velocity, Vector2.UP)

		HAMMER:
			velocity.x = 0
			animation.play("HammerAttack")
			timer.start(4)
			if timer.time_left == 0:
				state = MOVING
			velocity.y += gravity * delta
			move_and_slide(velocity, Vector2.UP)

		DEAD:
			animation.play("Dying")

func die():
	queue_free()

func return_to_move():
	state = MOVING

func see_to_attack():
	if not eyes.is_colliding(): return false
	var collider = eyes.get_collider()
	if not collider.is_in_group("protagonists"): return false
	return true

func attack():
	var projectile = Bullet.instance()
	projectile.global_position = shockwavesource.global_position
	if direction == Vector2.RIGHT:
		projectile.velocity.x = projectile.speed * 10
	elif direction == Vector2.LEFT:
		projectile.velocity.x = projectile.speed * -10
	get_tree().get_root().add_child(projectile)
	timer.start(1)

func detect_turn_around():
	if not floordetect.is_colliding() and is_on_floor():
		direction *= -1
#		sprite.flip_h = direction.x < 0
		scale.x = -scale.x

func _on_Hurtbox_area_entered(area):
	if area.name == "PlayerMelee":
		state = DEAD
	if area.is_in_group("uulgahurtsyou"):
		state = DEAD
