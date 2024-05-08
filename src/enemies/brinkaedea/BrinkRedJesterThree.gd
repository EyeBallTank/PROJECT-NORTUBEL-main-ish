extends KinematicBody2D

#ISSUES:
#Recreated the Red Jester and this time, the animation was called "laugh" since the beginning
#but the issue still showed up
#So then I renamed it "abouttosummon" and it's still there

export var gravity: = 3700

var direction = Vector2.RIGHT
var velocity = Vector2.ZERO
var walk_speed = 160

onready var sprites = $AnimatedSprite
onready var animation = $AnimationPlayer
onready var eyes = $RayCast2D
onready var timer = $Timer
onready var greenjestersource = $GreenJesterSource
onready var cloudeffect = $CloudEffect

var can_i_spawn_more = 0

const Bullet = preload("res://src/enemies/brinkaedea/BrinkGreenJester.tscn")
const cloud = preload("res://src/enemies/brinkaedea/SmokeCloud.tscn")

enum {
	MOVING,
	SUMMON,
	DEAD
}

var state = MOVING

func _ready():
	animation.play("RESET")

func _physics_process(delta):

	match state:
		MOVING:
			sprites.play("moving")
			if see_to_attack() and can_i_spawn_more < 5:
				state = SUMMON
			elif see_to_attack() and can_i_spawn_more == 5:
				pass
			var found_wall = is_on_wall()
			if found_wall:
				direction *= -1
				scale.x = -scale.x
			velocity.x = direction.x * walk_speed
			velocity.y += gravity * delta
			move_and_slide(velocity, Vector2.UP)


		SUMMON:
			velocity.x = 0
			animation.play("abouttosummon")
			timer.start(2)
			if timer.time_left == 0:
				state = MOVING
			velocity.y += gravity * delta
			move_and_slide(velocity, Vector2.UP)

		DEAD:
			animation.play("dying")
			velocity.x = 0
			velocity.y += gravity * delta
			move_and_slide(velocity, Vector2.UP)

func red_jester_lost():
	Signals.emit_signal("red_jester_hurt")

func attack():
	can_i_spawn_more += 1
	var grenade = Bullet.instance()
	get_tree().get_root().add_child(grenade)
	grenade.global_position = greenjestersource.global_position
	timer.start(0.5)

	var smokecloud = cloud.instance()
	get_tree().get_root().add_child(smokecloud)
	smokecloud.global_position = cloudeffect.global_position
	timer.start(0.5)

func see_to_attack():
	if not eyes.is_colliding(): return false
	var collider = eyes.get_collider()
	if not collider.is_in_group("protagonists"): return false
#	if not collider is StellaMain: return false
#	if not collider is Companion: return false
	return true

func return_to_move():
	state = MOVING

func die():
	queue_free()


func _on_EnemyHurtbox_area_entered(area):
	if area.name == "PlayerMelee":
		state = DEAD
	if area.name == "EnemyCrusher":
		state = DEAD

