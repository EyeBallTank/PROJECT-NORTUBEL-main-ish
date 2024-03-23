extends KinematicBody2D

var direction = Vector2.RIGHT
var velocity = Vector2.ZERO

onready var sprite: = $AnimatedSprite
onready var animation = $AnimationPlayer
onready var timer = $Timer
onready var spritetimer = $SpriteTimer
onready var gunhole = $Gunhole
onready var orbsource = $OrbSource
#onready var grenadetimer = $grenadetimer
var phase = 3

var canattack = true
var canmove = true

onready var shieldsprite = $shieldSprite

const Bullet = preload("res://src/bosses/ZharkBulletSpreadTest.tscn")
const BasicTwoOrbs = preload("res://src/bosses/ZharkTwoBasicOrbs.tscn")
const WorseTwoOrbs = preload("res://src/bosses/ZharkTwoWorseOrbs.tscn")
#const Grenade = preload("res://src/bosses/ZharkGrenadeTest.tscn")

enum {
	MOVING,
	SHOOT,
	HURT,
	DEAD
}

var state = MOVING

func _ready():
	shieldsprite.show()
	Signals.connect("turn_off_zhark_shield", self, "oh_no_my_shield")
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
				velocity = direction * 360
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

#			if grenadetimer.time_left == 0:
#				bombdrop()
#

		HURT:
#			velocity = 0
			shieldsprite.hide()
			animation.play("Hurting")
			
		DEAD:
			animation.play("Dying.")
			velocity = 0
			canmove = false
			canattack = false
			shieldsprite.hide()


func return_to_move():
	
	
	timer.start(2)
	if phase < 4:
		canmove = true
		canattack = true
		state = MOVING
		sprite.animation = "Moving"
		shieldsprite.show()
	elif phase == 4:
		state = DEAD
	

func attack():
	var projectile = Bullet.instance()
	projectile.global_position = gunhole.global_position
#	projectile.velocity.y = projectile.speed * 10
	get_tree().get_root().add_child(projectile)
	sprite.animation = "Attack"
	if phase == 1:
		pass
	elif phase == 2:
		var doubleorbs = BasicTwoOrbs.instance()
		doubleorbs.global_position = orbsource.global_position
		get_tree().get_root().add_child(doubleorbs)

	elif phase == 3:
		
		var badorbs = WorseTwoOrbs.instance()
		badorbs.global_position = orbsource.global_position
		get_tree().get_root().add_child(badorbs)




	spritetimer.start(1)

#func bombdrop():
#	var bomb = Grenade.instance()
#	bomb.global_position = orbsource.global_position
#	get_tree().get_root().add_child(bomb)
#

func send_a_signal():
	Signals.emit_signal("collectible_picked")

func add_to_phase():
	phase += 1

func oh_no_my_shield():
	state = HURT



