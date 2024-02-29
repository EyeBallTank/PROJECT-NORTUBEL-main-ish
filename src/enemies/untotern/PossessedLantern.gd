extends KinematicBody2D

export var speed = 120
var comp_position
var target_position
onready var companion = get_parent().get_node("Companion")
onready var sprite = $AnimatedSprite
onready var animation = $AnimationPlayer

enum {
	IDLE,
	ACTIVE,
	DEAD
}

var state = IDLE

func _ready():
	animation.play("RESET")

func _physics_process(delta):
	match state:
		IDLE:
			pass

		ACTIVE:
			comp_position = companion.position
			target_position = (comp_position - position).normalized()

			if position.distance_to(comp_position) > 3:
				move_and_slide(target_position * speed)
			if companion.health == 0:
				state = IDLE
# Guess the 0 health detection part works?
		DEAD:
			animation.play("dying")

func die():
	queue_free()

func _on_Vision_body_entered(body):
	if body.name == "Companion":
		state = ACTIVE


func _on_enemyhurtbox_body_entered(body):
	if body.name == "SoccerBall":
		state = DEAD

func _on_enemyhurtbox_area_entered(area):
	if area.name == "PlayerMelee":
		state = DEAD
	if area.name == "EnemyCrusher":
		state = DEAD
