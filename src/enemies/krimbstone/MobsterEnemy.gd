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
var canattack = false
var canmove = true

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
					sprite.flip_h = direction.x < 0
				#using flip V instead of H because of the angle of the placeholder sprite
				#if i give the Gecko proper sprites, this will change
				velocity = direction * 160
				velocity.y += gravity * delta
				move_and_slide(velocity, Vector2.UP)
			elif canmove == false:
				velocity = 0
			if canattack == true:
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
	sprite.play("Attack")
	sound.play()
	timer.start(0.5)
	if timer.time_left == 0:
		pass

func _on_Eyes_body_entered(body):
	if body.is_in_group("protagonists"):
		canattack = true
		canmove = false

func _on_Eyes_body_exited(body):
	if body.is_in_group("protagonists"):
		canattack = false
		canmove = true

func _on_EnemyHurtbox_area_entered(area):
	if area.name == "PlayerMelee":
		state = DEAD
	if area.name == "EnemyCrusher":
		state = DEAD
