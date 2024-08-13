extends KinematicBody2D

export var gravity: = 23600

var direction = Vector2.RIGHT
var velocity = Vector2.ZERO

onready var sprite: = $AnimatedSprite
onready var eyes = $RayCast2D
onready var animation = $AnimationPlayer
onready var timer = $Timer
onready var arrowsource = $ArrowSource

const Bullet = preload("res://src/level_hazards/herrko/GhalbeenArrow.tscn")

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



func _on_EnemyHurtbox_area_entered(area):
	if area.name == "PlayerMelee":
		state = DEAD
	if area.is_in_group("uulgahurtsyou"):
		state = DEAD
