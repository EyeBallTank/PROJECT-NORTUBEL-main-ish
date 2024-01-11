extends KinematicBody2D

var velocity = Vector2(200, 200)
var horizdirection = Vector2.RIGHT
var vertidirection = Vector2.UP
onready var animation = $AnimationPlayer

export var customstate = 1

enum {
	DIAGONAL,
	HORIZONTAL,
	VERTICAL
}

var state = DIAGONAL

func _ready():
	animation.play("RESET")

func _physics_process(delta):
	if customstate == 1:
		state = DIAGONAL
	elif customstate == 2:
		state = HORIZONTAL
	elif customstate == 3:
		state = VERTICAL

	match state:
		DIAGONAL:
			var collision_info = move_and_collide(velocity * delta)
			if collision_info:
				velocity = velocity.bounce(collision_info.normal)

		HORIZONTAL:
			var found_wall = is_on_wall()
			if found_wall:
				horizdirection *= -1
			velocity = horizdirection * 290
			move_and_slide(velocity, Vector2.UP)

		VERTICAL:
			var hitceiling = is_on_ceiling()
			var hitfloor = is_on_floor()
			if hitfloor:
				vertidirection *= -1
			if hitceiling:
				vertidirection *= -1
			velocity = vertidirection * 290
			move_and_slide(velocity, Vector2.UP)


func die():
	queue_free()

func _on_TargetDelete_body_entered(body):
	if body.name == "SoccerBall":
		animation.play("dying")

func _on_TargetDelete_area_entered(area):
	if area.name == "PlayerMelee":
		animation.play("dying")
	if area.name == "EnemyCrusher":
		animation.play("dying")
