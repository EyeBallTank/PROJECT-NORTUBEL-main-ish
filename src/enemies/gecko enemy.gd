extends KinematicBody2D

export var gravity: = 29600

var direction = Vector2.RIGHT
var velocity = Vector2.ZERO
var knockback_dir = 1
onready var sprite: = $Sprite
onready var animation: = $AnimationPlayer

enum {
	ALIVE,
	DEAD
}

var state = ALIVE

func _ready():
	animation.play("RESET")

func _physics_process(delta):
	match state:
		ALIVE:
			var found_wall = is_on_wall()
			if found_wall:
				direction *= -1
				sprite.flip_h = direction.x > 0
				#using flip V instead of H because of the angle of the placeholder sprite
				#if i give the Gecko proper sprites, this will change
			velocity = direction * 290
			velocity.y += gravity * delta
			move_and_slide(velocity, Vector2.UP)

func _on_GeckoHurtbox_area_entered(area):
	if area.name == "PlayerMelee":
		animation.play("dying")
	if area.name == "EnemyCrusher":
		animation.play("dying")

func _on_GeckoHurtbox_body_entered(body):
	if body.name == "SoccerBall":
		animation.play("dying")

func die():
	queue_free()
