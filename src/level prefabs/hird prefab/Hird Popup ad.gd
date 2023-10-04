extends KinematicBody2D

var velocity = Vector2(400, 400)
onready var animation = $AnimationPlayer

func _ready():
	animation.play("default")

func _physics_process(delta):

	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
		velocity = velocity.bounce(collision_info.normal)

func die():
	queue_free()


func _on_PopupHurtbox_area_entered(area):
	if area.name == "PlayerMelee":
		animation.play("dying")
	if area.name == "EnemyCrusher":
		animation.play("dying")
