extends Node2D
#Once again copied the script from HeartBeast
enum {HOVER, FALL, LAND, RISE}

var state = HOVER

onready var start_position = global_position
onready var raycast = $RayCast2D
onready var sound = $AudioStreamPlayer
onready var sprite = $AnimatedSprite
onready var timer = $Timer

func _ready():
	sound.set_volume_db(-80)

func _physics_process(delta):
	match state:
		HOVER: hover_state()
		FALL: fall_state(delta)
		LAND: land_state()
		RISE: rise_state(delta)

func hover_state():
	state = FALL

func fall_state(delta):
	sprite.animation = "falling"
	position.y += 1000 * delta
	if raycast.is_colliding():
		var collision_point = raycast.get_collision_point()
		position.y = collision_point.y
		state = LAND
		sound.play()
		timer.start(1.0)

func land_state():
	if timer.time_left == 0:
		state = RISE

func rise_state(delta):
	sprite.animation = "rising"
	position.y = move_toward(position.y, start_position.y, 100 * delta)
	if position.y == start_position.y:
		state = HOVER


func _on_SoundProximity_body_entered(body):
	if body.name == "Player":
		sound.set_volume_db(-3.736) 


func _on_SoundProximity_body_exited(body):
	if body.name == "Player":
		sound.set_volume_db(-80) 
