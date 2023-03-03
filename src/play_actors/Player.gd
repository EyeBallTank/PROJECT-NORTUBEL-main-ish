extends actor

# EyeBall here, as you can see i copied code from the Cubio demo
# My IRL schedule is a bit of a mess, so don't expect professionalism that much
# Credit to the Godot team and anyone for making resources that i keep Frankensteining into my projects

#The following comments are not my own, if that isn't clear enough

#THESE ARE PREPERATIONS FOR FUTURE PLAYER SATES
#enum {
#	MAINSTATE,
#	CLIMB,
#	PUSH,
#	SWIM,
#	SWING,
#	KICK,
#	KNIFE
#}

#var state = MAINSTATE

const WALK_FORCE = 1600
const WALK_MAX_SPEED = 700
const STOP_FORCE = 450
const JUMP_SPEED = 1500

func _physics_process(delta):
	# Horizontal movement code. First, get the player's input.
	var walk = WALK_FORCE * (Input.get_action_strength("right") - Input.get_action_strength("left"))
	# Slow down the player if they're not trying to move.
	if abs(walk) < WALK_FORCE * 0.1:
		# The velocity, slowed down a bit, and then reassigned.
		velocity.x = move_toward(velocity.x, 0, STOP_FORCE * delta)
	else:
		velocity.x += walk * delta
	# Clamp to the maximum horizontal movement speed.
	velocity.x = clamp(velocity.x, -WALK_MAX_SPEED, WALK_MAX_SPEED)

	# Vertical movement code. Apply gravity.
	velocity.y += gravity * delta

	# Move based on the velocity and snap to the ground.
	velocity = move_and_slide_with_snap(velocity, Vector2.DOWN, Vector2.UP)

	# Check for jumping. is_on_floor() must be called after movement code.
	if is_on_floor() and Input.is_action_just_pressed("jumpup"):
		velocity.y = -JUMP_SPEED
