extends Node2D
#Once again copied the script from HeartBeast
enum {HOVER, FALL, LAND, RISE}

var state = HOVER

onready var start_position = global_position
onready var raycast = $RayCast2D
onready var sound = $AudioStreamPlayer

func _physics_process(delta):
	match state:
		HOVER: hover_state()
		FALL: fall_state(delta)
		LAND: land_state()
		RISE: rise_state(delta)

func hover_state():
	state = FALL

func fall_state(delta):
	position.y += 1000 * delta
	if raycast.is_colliding():
		var collision_point = raycast.get_collision_point()
		position.y = collision_point.y
		state = LAND

func land_state():
	sound.play()
	state = RISE

func rise_state(delta):
	position.y = move_toward(position.y, start_position.y, 100 * delta)
	if position.y == start_position.y:
		state = HOVER
