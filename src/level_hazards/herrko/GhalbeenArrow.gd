extends KinematicBody2D

export var speed = 160

var player_position
var target_position
var player
#onready var player = get_parent().get_node("Player")
onready var animation = $AnimationPlayer
#Fixed thanks to a kind anon on /vg/

func _ready():
	animation.play("RESET")
	Signals.connect("scene_has_changed", self, "therefore_I_Go")

func _physics_process(delta):
	if not is_instance_valid(player):
		return

	player_position = player.position
	target_position = (player_position - position).normalized()

	if position.distance_to(player_position) > 3:
		move_and_slide(target_position * speed)
		look_at(player_position)

	if is_on_wall():
		animation.play("Dying")

	if is_on_floor():
		animation.play("Dying")

	if is_on_ceiling():
		animation.play("Dying")

func die():
	queue_free()

func therefore_I_Go():
	die()


func _on_Touchplayer_body_entered(body):
	if body.is_in_group("protagonists"):
		animation.play("Dying")


func _on_HurtArrow_area_entered(area):
	if area.name == "PlayerMelee":
		animation.play("Dying")
