extends KinematicBody2D

#ISSUES:
#MUCH LIKE RED GHALBEEN. HE CAN'T TURN AROUND WHEN COLLIDING WITH WALLS


export var gravity: = 3700

var direction = Vector2.RIGHT
var velocity = Vector2.ZERO
var walk_speed = 160

onready var sprites = $AnimatedSprite
onready var animation = $AnimationPlayer
onready var eyes = $RayCast2D
onready var timer = $Timer

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
			if see_to_attack():
				state = SUMMON
			var found_wall = is_on_wall()
			if found_wall:
				direction *= -1
				scale.x = -scale.x
			velocity.x = direction.x * walk_speed
			velocity.y += gravity * delta
			move_and_slide(velocity, Vector2.UP)


		SUMMON:
			velocity.x = 0
			animation.play("attack")
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

func attack():
	pass

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



func _on_EnemyHurtbox_area_exited(area):
	if area.name == "PlayerMelee":
		state = DEAD
	if area.name == "EnemyCrusher":
		state = DEAD
