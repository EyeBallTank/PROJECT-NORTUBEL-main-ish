extends KinematicBody2D

onready var animation = $AnimationPlayer
onready var sprite = $AnimatedSprite
onready var raycast = $RayCast2D
onready var timer = $Timer
onready var shockwavespawn = $Position2D

var direction = Vector2.RIGHT
var velocity = Vector2.ZERO

const Shockwave = preload("res://src/bosses/amalia/AmaliaWorseHandShockwave.tscn")

enum {
	FLOATING,
	SLAM,
	DEAD
}

var state = FLOATING


func _ready():
	Signals.connect("scene_has_changed", self, "therefore_I_Go")
	animation.play("RESET")
	sprite.play("handnormal")

func _physics_process(delta):
	match state:
		FLOATING:
			sprite.play("handnormal")
			if see_to_punch():
				state = SLAM
			velocity = direction * 490
			move_and_slide(velocity, Vector2.UP)
			var found_wall = is_on_wall()
			if found_wall:
				direction *= -1
		SLAM:
			animation.play("slamming")
			velocity = 0
			timer.start(5)
			if timer.time_left == 0:
				state = FLOATING
		DEAD:
			animation.play("dying")

func see_to_punch():
	if not raycast.is_colliding(): return false
	var collider = raycast.get_collider()
	if not collider.is_in_group("protagonists"): return false
	return true

func return_to_move():
	state = FLOATING

func die():
	queue_free()

func therefore_I_Go():
	die()

func send_a_signal_to_amalia():
	Signals.emit_signal("hand_was_destroyed")

func shockwave_summon():
	var shockwaveattack = Shockwave.instance()
	shockwaveattack.global_position = shockwavespawn.global_position
	get_tree().get_root().add_child(shockwaveattack)

func _on_Hurtbox_area_entered(area):
	if area.name == "PlayerMelee":
		send_a_signal_to_amalia()
		state = DEAD
