extends KinematicBody2D

export var gravity: = 29600

var direction = Vector2.RIGHT
var velocity = Vector2.ZERO
var knockback_dir = 1
onready var sprite: = $AnimatedSprite
onready var floordetect = $Floordetect
onready var eyes = $Eyes
onready var animation = $AnimationPlayer

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
		SHOOT:
			sprite.play("Attack")
		DEAD:
			animation.play("Dying.")

func detect_turn_around():
	if not floordetect.is_colliding() and is_on_floor():
		direction *= -1
#		sprite.flip_h = direction.x < 0
		scale.x = -scale.x

func die():
	queue_free()

func _on_Eyes_body_entered(body):
	if body.is_in_group("protagonists"):
		state = SHOOT


func _on_Eyes_body_exited(body):
	if body.is_in_group("protagonists"):
		state = MOVING

func _on_EnemyHurtbox_area_entered(area):
	if area.name == "PlayerMelee":
		state = DEAD
	if area.name == "EnemyCrusher":
		state = DEAD
