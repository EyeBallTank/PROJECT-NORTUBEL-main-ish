extends KinematicBody2D

var velocity = Vector2(200, 200)
onready var animation = $AnimationPlayer

func _ready():
	animation.play("RESET")

func _physics_process(delta):

	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
		velocity = velocity.bounce(collision_info.normal)

func die():
	queue_free()


func _on_HirdrioHurtbox_body_entered(body):
	if body.name == "SoccerBall":
		animation.play("dying")


func _on_HirdrioHurtbox_area_entered(area):
	if area.name == "PlayerMelee":
		animation.play("dying")
	if area.name == "EnemyCrusher":
		animation.play("dying")
