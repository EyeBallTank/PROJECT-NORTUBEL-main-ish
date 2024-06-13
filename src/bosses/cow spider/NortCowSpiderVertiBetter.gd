extends KinematicBody2D

var vertidirection = Vector2.UP
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
			var hitceiling = is_on_ceiling()
			var hitfloor = is_on_floor()
			if hitfloor:
				vertidirection *= -1
				sprite.flip_v = false
			if hitceiling:
				vertidirection *= -1
				sprite.flip_v = true
			velocity = vertidirection * 390
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
