extends KinematicBody2D

var velocity = Vector2(200, 200)
var horizdirection = Vector2.RIGHT
var vertidirection = Vector2.UP

onready var animationplayer = $AnimationPlayer
export var customstate = 1

enum {
	DIAGONAL,
	HORIZONTAL,
	VERTICAL
}

var state = DIAGONAL


func _ready():
	animationplayer.play("RESET")

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

func disappear():
	queue_free()

func send_a_signal():
	Signals.emit_signal("collectible_picked")

func _on_BallDetector_area_exited(area):
	if area.name == "GoalDetector":
		$AudioStreamPlayer.play()
		animationplayer.play("ballreceived")

func _on_BallDetector_body_entered(body):
	if body.name == "SoccerBall":
		$AudioStreamPlayer.play()
		animationplayer.play("ballreceived")
