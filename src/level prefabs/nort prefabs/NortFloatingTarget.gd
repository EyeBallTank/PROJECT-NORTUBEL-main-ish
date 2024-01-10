extends KinematicBody2D

var velocity = Vector2(200, 200)
onready var animation = $AnimationPlayer

#export var customstate = "DIAGONAL"

enum {
	DIAGONAL,
	HORIZONTAL,
	VERTICAL
}

var state = DIAGONAL

func _ready():
	animation.play("RESET")

func _physics_process(delta):
	match state:
		DIAGONAL:
			var collision_info = move_and_collide(velocity * delta)
			if collision_info:
				velocity = velocity.bounce(collision_info.normal)

		HORIZONTAL:
			pass

		VERTICAL:
			pass


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
