extends KinematicBody2D

export var gravity: = 23600

var direction = Vector2.RIGHT
var velocity = Vector2.ZERO

onready var sprite: = $AnimatedSprite
onready var eyeselec = $EyesElec
onready var eyesstar = $EyesStar
onready var animation = $AnimationPlayer
onready var timer = $Timer
onready var elecspawn = $ElecSpawn
onready var starspawn = $StarSpawn
var canattack = false
var canmove = true

const Elec = preload("res://src/enemies/lahiurn/LahiurnNightRiderElec.tscn")

const StarProjectile = preload("res://src/enemies/lahiurn/LahiurnMorningStar.tscn")
const StarProjectileLeft = preload("res://src/enemies/lahiurn/LahiurnMorningStarLEFT.tscn")



enum {
	MOVING,
	STAR,
	ELEC,
	DEAD
}

var state = MOVING

func _ready():
	animation.play("RESET")

func _physics_process(delta):

	match state:
		MOVING:
			if see_to_elec():
				state = ELEC
			if see_to_star():
				state = STAR
			sprite.play("moving")
			var found_wall = is_on_wall()
			if found_wall:
				direction *= -1
				scale.x = -scale.x
			velocity = direction * 160
			velocity.y += gravity * delta
			move_and_slide(velocity, Vector2.UP)
			gravity = 37600

		STAR:
			velocity.x = 0
			animation.play("MorningStarAttack")
			timer.start(2)
			if timer.time_left == 0:
				state = MOVING
			velocity.y += gravity * delta
			move_and_slide(velocity, Vector2.UP)

		ELEC:
			velocity.x = 0
			animation.play("ElectrictyAttack")
			timer.start(2)
			if timer.time_left == 0:
				state = MOVING
			velocity.y += gravity * delta
			move_and_slide(velocity, Vector2.UP)

		DEAD:
			animation.play("Dying")
#			sprite.play("dead")

func die():
	queue_free()

func see_to_elec():
	if not eyeselec.is_colliding(): return false
	var collider = eyeselec.get_collider()
	if not collider.is_in_group("protagonists"): return false
	return true

func see_to_star():
	if not eyesstar.is_colliding(): return false
	var collider = eyesstar.get_collider()
	if not collider.is_in_group("protagonists"): return false
	return true

func return_to_move():
	state = MOVING

func attack():
	var elec_hurt = Elec.instance()
	get_tree().get_root().add_child(elec_hurt)
	elec_hurt.global_position = elecspawn.global_position
	timer.start(0.5)

func attack_star():

	if direction == Vector2.RIGHT:
		var star_hurt = StarProjectile.instance()
		get_tree().get_root().add_child(star_hurt)
		star_hurt.global_position = starspawn.global_position
	elif direction == Vector2.LEFT:
		var star_hurt_left = StarProjectileLeft.instance()
		get_tree().get_root().add_child(star_hurt_left)
		star_hurt_left.global_position = starspawn.global_position

	timer.start(0.5)


func _on_EnemyHurtbox_area_entered(area):
	if area.name == "PlayerMelee":
		state = DEAD
