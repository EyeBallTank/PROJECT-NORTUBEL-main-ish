extends KinematicBody2D

export var gravity: = 23600

var direction = Vector2.RIGHT
var velocity = Vector2.ZERO

onready var sprite: = $AnimatedSprite
onready var eyes = $RayCast2D
onready var animation = $AnimationPlayer
onready var timer = $Timer
onready var arrowsource = $ArrowSource
onready var walldetect = $wall_detect

const Bullet = preload("res://src/level_hazards/herrko/GhalbeenArrow.tscn")
#NOTE: THIS GUY IS BROKEN
#His movement is a mess
#Still can't turn when touching walls

var player_position
var target_position
onready var player = get_parent().get_node("chasingtargettest")

enum {
	MOVING,
	ARROW,
	DEAD
}

var state = MOVING

func _ready():
	animation.play("RESET")

func _physics_process(delta):
	player_position = player.position
	target_position = (player_position - position).normalized()

	match state:
		MOVING:
			detect_turn_around()
			if see_to_attack():
				state = ARROW

			sprite.play("moving")
			var found_wall = is_on_wall()
			if found_wall:
				direction *= -1
				scale.x = -scale.x
			velocity = direction * 160
			velocity.y += gravity * delta
			move_and_slide(velocity, Vector2.UP)
#			gravity = 23600


		ARROW:
			velocity.x = 0
			animation.play("Shoot")
			timer.start(2)
			if timer.time_left == 0:
				state = MOVING
			velocity.y += gravity * delta
			move_and_slide(velocity, Vector2.UP)

		DEAD:
			animation.play("Dying")

func return_to_move():
	state = MOVING

func die():
	queue_free()

func see_to_attack():
	if not eyes.is_colliding(): return false
	var collider = eyes.get_collider()
	if not collider.is_in_group("player"): return false
	return true

func attack():
	var projectile = Bullet.instance()
	projectile.global_position = arrowsource.global_position
	projectile.player = player
	get_tree().get_root().add_child(projectile)

	if projectile.position.distance_to(player_position) > 3:
		projectile.move_and_slide(target_position * projectile.speed)
		projectile.look_at(player_position)
#		projectile.player_position = projectile.player


func detect_turn_around():
	if not walldetect.is_colliding() and is_on_wall():
		direction *= -1
#		sprite.flip_h = direction.x < 0
		scale.x = -scale.x

func _on_EnemyHurtbox_area_entered(area):
	if area.name == "PlayerMelee":
		state = DEAD
	if area.is_in_group("uulgahurtsyou"):
		state = DEAD
