extends KinematicBody2D

export var speed = 120
var comp_position
var target_position
onready var companion = get_parent().get_node("Companion")

enum {
	IDLE,
	ACTIVE
}

var state = IDLE

func _physics_process(delta):
	match state:
		IDLE:
			pass

		ACTIVE:
			comp_position = companion.position
			target_position = (comp_position - position).normalized()

			if position.distance_to(comp_position) > 3:
				move_and_slide(target_position * speed)

func _on_Vision_body_entered(body):
	if body.name == "Companion":
		state = ACTIVE
