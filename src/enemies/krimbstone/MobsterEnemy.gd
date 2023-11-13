extends KinematicBody2D

export var gravity: = 29600

var direction = Vector2.RIGHT
var velocity = Vector2.ZERO
var knockback_dir = 1
onready var sprite: = $AnimatedSprite
onready var floordetect = $Floordetect
onready var eyes = $Eyes
onready var eyescollosion = $Eyes/CollisionShape2D
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
			if canmove == true:
				detect_turn_around()
				sprite.play("Running")
				var found_wall = is_on_wall()
				if found_wall:
					direction *= -1
					scale.x = -scale.x
				velocity = direction * 160
				velocity.y += gravity * delta
				move_and_slide(velocity, Vector2.UP)
			elif canmove == false:
				velocity = 0
			if canattack == true:
				sprite.play("Attack")
				attack()
			elif canattack == false:
				pass

		DEAD:
			animation.play("Dying.")
			canmove = false
			canattack = false

func detect_turn_around():
	if not floordetect.is_colliding() and is_on_floor():
		direction *= -1
#		sprite.flip_h = direction.x < 0
		scale.x = -scale.x

func die():
	queue_free()

func attack():
	var projectile = Bullet.instance()
	projectile.global_position = gunhole.global_position
	get_tree().get_root().add_child(projectile)
	sprite.play("Attack")
	timer.start(0.5)
	if timer.time_left == 0:
		canattack = false
		canmove = true

func _on_Eyes_body_entered(body):
	if body.is_in_group("protagonists"):
		sound.play()
		canattack = true
		canmove = false
#		attack()

func _on_Eyes_body_exited(body):
	if body.is_in_group("protagonists"):
		canattack = false
		canmove = true
#		eyes.set_deferred("monitoring", true)

func _on_EnemyHurtbox_area_entered(area):
	if area.name == "PlayerMelee":
		state = DEAD
	if area.name == "EnemyCrusher":
		state = DEAD
