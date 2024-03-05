extends KinematicBody2D

export var gravity: = 3700

var direction = Vector2.RIGHT
var velocity = Vector2.ZERO
var walk_speed = 220

onready var sprites = $AnimatedSprite
onready var animation = $AnimationPlayer

enum {
	MOVING,
	DEAD
}

var state = MOVING

func _ready():
	animation.play("RESET")

func _physics_process(delta):
	match state:
		MOVING:
			sprites.play("moving")
			var found_wall = is_on_wall()
			if found_wall:
				direction *= -1
				scale.x = -scale.x
			velocity.x = direction.x * walk_speed
			velocity.y += gravity * delta
			move_and_slide(velocity, Vector2.UP)

		DEAD:
			animation.play("dying")
			velocity.x = 0
			velocity.y += gravity * delta
			move_and_slide(velocity, Vector2.UP)

func die():
	queue_free()


func _on_EnemyHurtbox_area_exited(area):
	if area.name == "PlayerMelee":
		state = DEAD
	if area.name == "EnemyCrusher":
		state = DEAD
