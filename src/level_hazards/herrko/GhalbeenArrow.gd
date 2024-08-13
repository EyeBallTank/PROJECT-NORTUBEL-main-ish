extends KinematicBody2D

export var speed = 140

var player_position
var target_position
var player
#onready var player_reference = get_parent().get_node("Player")
onready var animation = $AnimationPlayer
#THIS SCENE IS BROKEN AND SO IS ITS ENEMY
#Seems it breaks the game, as if a spawned scene can't reference the player in the script

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
