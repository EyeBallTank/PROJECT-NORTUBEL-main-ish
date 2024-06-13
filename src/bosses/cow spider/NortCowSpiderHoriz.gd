extends KinematicBody2D

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
			velocity = direction * 390
			move_and_slide(velocity, Vector2.UP)
		DEAD:
			animation.play("dying")
			velocity = 0

func die():
	queue_free()

func _on_SpiderHurtbox_area_entered(area):
	if area.name == "PlayerMelee":
		state = DEAD
	if area.name == "EnemyCrusher":
		state = DEAD
