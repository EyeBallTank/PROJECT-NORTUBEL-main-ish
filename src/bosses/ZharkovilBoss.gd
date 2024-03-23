extends KinematicBody2D

var direction = Vector2.RIGHT
var velocity = Vector2.ZERO

onready var sprite: = $AnimatedSprite
onready var eyes = $Eyes
onready var animation = $AnimationPlayer
onready var timer = $Timer
onready var spritetimer = $SpriteTimer
onready var gunhole = $Gunhole
onready var orbsource = $OrbSource
var phase = 1

var canattack = true
var canmove = true

const Bullet = preload("res://src/bosses/VerticalBullet.tscn")
#const ShotgunBlastLeft = preload("res://src/enemies/greklovick/GrekShotgunPelletsLeft.tscn")
#const Bomb = preload("res://src/enemies/greklovick/TemporaryExplosion.tscn")

enum {
	MOVING,
	SHOOT,
	HURT,
	DEAD
}

var state = MOVING

func _ready():
	sprite.animation = "Moving"
	timer.start(2)
	animation.play("RESET")

func _physics_process(delta):

	match state:
		MOVING:
			if canmove == true:
				var found_wall = is_on_wall()
				if found_wall:
					direction *= -1
				velocity = direction * 160
				move_and_slide(velocity, Vector2.UP)
			elif canmove == false:
				velocity = 0
			if timer.time_left == 0:
				if canattack == true:
					canmove = false
					attack()
					timer.start(5)
				elif canattack == false:
					pass
			if spritetimer.time_left == 0:
				sprite.animation = "Moving"
				canmove = true


		HURT:
			pass
			
		DEAD:
			pass


func return_to_move():
	canmove = true
	canattack = true
	timer.start(2)
	if phase < 4:
		state = MOVING
	elif phase == 4:
		state = DEAD
	

func attack():
	var projectile = Bullet.instance()
	projectile.global_position = gunhole.global_position
	projectile.velocity.y = projectile.speed * 10
	get_tree().get_root().add_child(projectile)
	sprite.animation = "Attack"
	if phase == 1:
		pass
	elif phase == 2:
		pass
	elif phase == 3:
		pass
	spritetimer.start(1)

func send_a_signal():
	Signals.emit_signal("collectible_picked")

func add_to_phase():
	phase += 1
