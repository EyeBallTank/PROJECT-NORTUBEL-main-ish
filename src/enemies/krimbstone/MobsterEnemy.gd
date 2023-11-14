extends KinematicBody2D

export var gravity: = 23600

var direction = Vector2.RIGHT
var velocity = Vector2.ZERO

onready var sprite: = $AnimatedSprite
onready var floordetect = $Floordetect
onready var eyes = $Eyes
#onready var eyescollosion = $Eyes/CollisionShape2D
onready var animation = $AnimationPlayer
onready var sound = $AudioStreamPlayer
onready var timer = $Timer
onready var gunhole = $Position2D
var canattack = false
var canmove = true

const Bullet = preload("res://src/enemies/krimbstone/Bullet.tscn")

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
#			sprite.play("Attack")
#			attack()
#			timer.start(0.5)
#			if timer.time_left == 0:
#				state = MOVING
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

func attack():
	sound.play()
	var projectile = Bullet.instance()
	projectile.global_position = gunhole.global_position
#	projectile.direction = direction
#	projectile.speed = direction * projectile.velocity
	if direction == Vector2.RIGHT:
		projectile.velocity.x = projectile.speed * 10
	elif direction == Vector2.LEFT:
		projectile.velocity.x = projectile.speed * -10
	get_tree().get_root().add_child(projectile)
	sprite.play("Attack")
	timer.start(0.5)

#func _on_Eyes_body_entered(body):
#	if body.is_in_group("protagonists"):
#		sound.play()
#		canattack = true
#		canmove = false
#		attack()

#func _on_Eyes_body_exited(body):
#	if body.is_in_group("protagonists"):
#		canattack = false
#		canmove = true
#		eyes.set_deferred("monitoring", true)

func _on_EnemyHurtbox_area_entered(area):
	if area.name == "PlayerMelee":
		state = DEAD
	if area.name == "EnemyCrusher":
		state = DEAD
