extends KinematicBody2D
class_name StellaMain

enum {
	FOLLOWME,
	STANDSTILL,
	CLIMBIDLE,
	CLIMBMOVE,
	CLIMBRUN,
	PUSHFOLLOW,
	PUSHRUN,
	DEATH,
	HURT,
	RUNAWAY
}

var state = STANDSTILL

var WALK_FORCE = 1600
var WALK_MAX_SPEED = 700
var PUSH_SPEED = 150
var STOP_FORCE = 450
var JUMP_SPEED = 1500

export var speed: = Vector2(300.0, 1000.0)
export var gravity: = 1450.0
export var health : int = 100

var vel: = Vector2.ZERO
var direction: = Vector2.ZERO
onready var Player = get_parent().get_node("Player")

onready var healthBar = $CanvasLayer/HealthbarStella
onready var StellaHurtbox = $StellaHurtbox
onready var ladderCheck = $LadderCheck
onready var animatedsprite = $AnimatedSprite
onready var pushdetector = $PushDetector

var last_checkpoint: Area2D = null
onready var checkpointTween = $CheckpointTween
var ouch = false
var immortal = false
onready var audioplayer = $AudioStreamPlayer
var was_on_floor = true

func _ready():
	Signals.connect("you_are_invincible", self, "_i_am_invincible")
	Signals.connect("player_died", self, "_on_Player_Died")
	immortal = false
	$FloaterActive.hide()
	healthBar.max_value = health
	var stellaspawn = get_parent().get_node("stellaspawn")
	last_checkpoint = stellaspawn

func _i_am_invincible():
	is_invul()

func _on_Player_Died():
	if state == FOLLOWME:
		state = STANDSTILL
	if state == RUNAWAY:
		state = STANDSTILL
	if state == CLIMBMOVE:
		state = CLIMBIDLE
	if state == CLIMBRUN:
		state = CLIMBIDLE
	if state == PUSHFOLLOW:
		state = STANDSTILL
	if state == PUSHRUN:
		state = STANDSTILL

func _physics_process(delta):
	healthBar.value = health
	if health <= 0  and state != DEATH:
		state = DEATH
		Signals.lives -= 1
		Signals.emit_signal("life_lost")

	match state:
		FOLLOWME:
			pass

			pushcheck()
			if Player.global_position.x < global_position.x - 10:
				vel.x = -WALK_MAX_SPEED
				direction.x = -1
			elif Player.global_position.x > global_position.x + 10:
				vel.x = WALK_MAX_SPEED
				direction.x = 1
			else:
				vel.x = 0
				direction.x = 0
			vel.x = direction.x * 630

			if direction.x == 1 and is_on_floor():
				animatedsprite.animation = "Running"
				animatedsprite.flip_h = false
				pushdetector.position = Vector2(63, 0)
			elif direction.x == -1 and is_on_floor():
				animatedsprite.animation = "Running"
				animatedsprite.flip_h = true
				pushdetector.position = Vector2(-59, 0)
			else:
				animatedsprite.animation = "Idle"

			vel.y += gravity * delta
			gravity = 1450.0
			vel = move_and_slide_with_snap(vel, Vector2.DOWN, Vector2.UP)

			if is_on_floor() and Input.is_action_just_pressed("stellajump"):
				vel.y = -JUMP_SPEED
				if vel.y < 0:
					vel.y += 500

			if vel.y < 0 and not is_on_floor():
				if ouch == false:
					animatedsprite.animation = "Jumpgoesup"
				elif ouch == true:
					animatedsprite.animation = "Hurt"
				if direction.x == 1:
					animatedsprite.flip_h = false
				elif direction.x == -1:
					animatedsprite.flip_h = true
			elif vel.y > 0 and not is_on_floor():
				if ouch == false:
					animatedsprite.animation = "Jumpgoesdown"
				elif ouch == true:
					animatedsprite.animation = "Hurt"
				if direction.x == 1:
					animatedsprite.flip_h = false
				elif direction.x == -1:
					animatedsprite.flip_h = true

			if is_on_floor() and not was_on_floor:
				audioplayer.play()
			was_on_floor = is_on_floor()

			if Input.is_action_pressed("stellacommand") and Input.is_action_just_pressed("left"):
				state = RUNAWAY
			if Input.is_action_pressed("stellacommand") and Input.is_action_just_pressed("down"):
				state = STANDSTILL
			if is_on_ladder():
				if Input.is_action_just_pressed("stellajump"):
					state = CLIMBIDLE

		STANDSTILL:
			pushcheck()
			vel.x = 0
			direction.x = 0
			vel.x = direction.x * 0

			if is_on_floor() and Input.is_action_just_pressed("stellajump"):
				vel.y = -JUMP_SPEED
				if vel.y < 0:
					vel.y += 500

			vel.y += gravity * delta
			gravity = 1450.0
			vel = move_and_slide_with_snap(vel, Vector2.DOWN, Vector2.UP)

			if is_on_floor() and not was_on_floor:
				audioplayer.play()
			was_on_floor = is_on_floor()

			if vel.y < 0 and not is_on_floor():
				if ouch == false:
					animatedsprite.animation = "Jumpgoesup"
				elif ouch == true:
					animatedsprite.animation = "Hurt"
				if direction.x == 1:
					animatedsprite.flip_h = false
				elif direction.x == -1:
					animatedsprite.flip_h = true
			elif vel.y > 0 and not is_on_floor():
				if ouch == false:
					animatedsprite.animation = "Jumpgoesdown"
				elif ouch == true:
					animatedsprite.animation = "Hurt"
				if direction.x == 1:
					animatedsprite.flip_h = false
				elif direction.x == -1:
					animatedsprite.flip_h = true

			if is_on_floor():
				animatedsprite.animation = "Idle"

			if Input.is_action_pressed("stellacommand") and Input.is_action_just_pressed("right"):
				state = FOLLOWME
			if Input.is_action_pressed("stellacommand") and Input.is_action_just_pressed("left"):
				state = RUNAWAY

			if is_on_ladder():
				if Input.is_action_just_pressed("stellajump"):
					state = CLIMBIDLE

		RUNAWAY:
			pushcheck()
			if Player.global_position.x < global_position.x - 10:
				vel.x = WALK_MAX_SPEED
				direction.x = 1
			elif Player.global_position.x > global_position.x + 10:
				vel.x = -WALK_MAX_SPEED
				direction.x = -1
			else:
				vel.x = 0
				direction.x = 0
			vel.x = direction.x * 700

			vel.y += gravity * delta
			gravity = 1450.0
			vel = move_and_slide_with_snap(vel, Vector2.DOWN, Vector2.UP)

			if is_on_floor() and not was_on_floor:
				audioplayer.play()
			was_on_floor = is_on_floor()

			if direction.x == 1 and is_on_floor():
				animatedsprite.animation = "Running"
				animatedsprite.flip_h = false
				pushdetector.position = Vector2(53, 0)
			elif direction.x == -1 and is_on_floor():
				animatedsprite.animation = "Running"
				animatedsprite.flip_h = true
				pushdetector.position = Vector2(-52, 0)
			else:
				animatedsprite.animation = "Idle"

			if is_on_floor() and Input.is_action_just_pressed("stellajump"):
				vel.y = -JUMP_SPEED
				if vel.y < 0:
					vel.y += 500

			if vel.y < 0 and not is_on_floor():
				if ouch == false:
					animatedsprite.animation = "Jumpgoesup"
				elif ouch == true:
					animatedsprite.animation = "Hurt"
				if direction.x == 1:
					animatedsprite.flip_h = false
				elif direction.x == -1:
					animatedsprite.flip_h = true
			elif vel.y > 0 and not is_on_floor():
				if ouch == false:
					animatedsprite.animation = "Jumpgoesdown"
				elif ouch == true:
					animatedsprite.animation = "Hurt"
				if direction.x == 1:
					animatedsprite.flip_h = false
				elif direction.x == -1:
					animatedsprite.flip_h = true

			if Input.is_action_pressed("stellacommand") and Input.is_action_just_pressed("right"):
				state = FOLLOWME
			if Input.is_action_pressed("stellacommand") and Input.is_action_just_pressed("down"):
				state = STANDSTILL

			if is_on_ladder():
				if Input.is_action_just_pressed("stellajump"):
					state = CLIMBIDLE

		CLIMBIDLE:
			if Player.global_position.y < global_position.y - 30:
				if Player.global_position.x < global_position.x - 90:
					animatedsprite.animation = "Climbidle"
					vel.x = 0
					direction.x = 0
					vel.y = 0
					direction.y = 0
				elif Player.global_position.x > global_position.x + 90:
					animatedsprite.animation = "Climbidle"
					vel.x = 0
					direction.x = 0
					vel.y = 0
					direction.y = 0
				else:
					animatedsprite.animation = "Climbidle"
					vel.x = 0
					direction.x = 0
					vel.y = 0
					direction.y = 0
			elif Player.global_position.y > global_position.y + 30:
				if Player.global_position.x < global_position.x - 90:
					animatedsprite.animation = "Climbidle"
					vel.x = 0
					direction.x = 0
					vel.y = 0
					direction.y = 0
				elif Player.global_position.x > global_position.x + 90:
					animatedsprite.animation = "Climbidle"
					vel.x = 0
					direction.x = 0
					vel.y = 0
					direction.y = 0
				else:
					animatedsprite.animation = "Climbidle"
					vel.x = 0
					direction.x = 0
					vel.y = 0
					direction.y = 0
			else:
				if Player.global_position.x < global_position.x - 90:
					animatedsprite.animation = "Climbidle"
					vel.x = 0
					direction.x = 0
					vel.y = 0
					direction.y = 0
				elif Player.global_position.x > global_position.x + 90:
					animatedsprite.animation = "Climbidle"
					vel.x = 0
					direction.x = 0
					vel.y = 0
					direction.y = 0
				else:
					state = STANDSTILL

			if Input.is_action_pressed("stellacommand") and Input.is_action_just_pressed("right"):
				state = CLIMBMOVE
			if Input.is_action_pressed("stellacommand") and Input.is_action_just_pressed("left"):
				state = CLIMBRUN
			if Input.is_action_just_pressed("stellajump"):
				state = STANDSTILL
			if not is_on_ladder():
				state = STANDSTILL

		CLIMBMOVE:
			if Player.global_position.y < global_position.y - 30:
				if Player.global_position.x < global_position.x - 90:
					vel = position.direction_to(Player.position) * speed
					animatedsprite.animation = "Climbing"
				elif Player.global_position.x > global_position.x + 90:
					vel = position.direction_to(Player.position) * speed
					animatedsprite.animation = "Climbing"
				else:
					vel = position.direction_to(Player.position) * speed
					animatedsprite.animation = "Climbing"
			elif Player.global_position.y > global_position.y + 30:
				if Player.global_position.x < global_position.x - 90:
					vel = position.direction_to(Player.position) * speed
					animatedsprite.animation = "Climbing"
				elif Player.global_position.x > global_position.x + 90:
					vel = position.direction_to(Player.position) * speed
					animatedsprite.animation = "Climbing"
				else:
					vel = position.direction_to(Player.position) * speed
					animatedsprite.animation = "Climbing"
			else:
				if Player.global_position.x < global_position.x - 90:
					animatedsprite.animation = "Climbidle"
					vel.x = 0
					direction.x = 0
					vel.y = 0
					direction.y = 0
				elif Player.global_position.x > global_position.x + 90:
					animatedsprite.animation = "Climbidle"
					vel.x = 0
					direction.x = 0
					vel.y = 0
					direction.y = 0
				else:
					state = STANDSTILL

			vel.x = direction.x * 390
#Why do i have to use vel.x and not vel.y here?
			vel = move_and_slide_with_snap(vel, Vector2.DOWN, Vector2.UP)

			if Input.is_action_pressed("stellacommand") and Input.is_action_just_pressed("down"):
				state = CLIMBIDLE
			if Input.is_action_pressed("stellacommand") and Input.is_action_just_pressed("left"):
				state = CLIMBRUN
			if Input.is_action_just_pressed("stellajump"):
				state = FOLLOWME
			if not is_on_ladder():
				state = FOLLOWME

		CLIMBRUN:
			if Player.global_position.y < global_position.y - 30:
				if Player.global_position.x < global_position.x - 90:
					vel = position.direction_to(Player.position) * -speed
					animatedsprite.animation = "Climbing"
				elif Player.global_position.x > global_position.x + 90:
					vel = position.direction_to(Player.position) * -speed
					animatedsprite.animation = "Climbing"
				else:
					vel = position.direction_to(Player.position) * -speed
					animatedsprite.animation = "Climbing"
			elif Player.global_position.y > global_position.y + 30:
				if Player.global_position.x < global_position.x - 90:
					vel = position.direction_to(Player.position) * -speed
					animatedsprite.animation = "Climbing"
				elif Player.global_position.x > global_position.x + 90:
					vel = position.direction_to(Player.position) * -speed
					animatedsprite.animation = "Climbing"
				else:
					vel = position.direction_to(Player.position) * -speed
					animatedsprite.animation = "Climbing"
			else:
				if Player.global_position.x < global_position.x - 90:
					animatedsprite.animation = "Climbidle"
					vel.x = 0
					direction.x = 0
					vel.y = 0
					direction.y = 0
				elif Player.global_position.x > global_position.x + 90:
					animatedsprite.animation = "Climbidle"
					vel.x = 0
					direction.x = 0
					vel.y = 0
					direction.y = 0
				else:
					state = STANDSTILL

			vel.x = direction.x * 390
#Why do i have to use vel.x and not vel.y here?
			vel = move_and_slide_with_snap(vel, Vector2.DOWN, Vector2.UP)

			if Input.is_action_pressed("stellacommand") and Input.is_action_just_pressed("down"):
				state = CLIMBIDLE
			if Input.is_action_pressed("stellacommand") and Input.is_action_just_pressed("right"):
				state = CLIMBMOVE
			if Input.is_action_just_pressed("stellajump"):
				state = RUNAWAY
			if not is_on_ladder():
				state = RUNAWAY

		DEATH:
			animatedsprite.animation = "Dead"
			vel.x = 0
			vel.y += gravity * delta
			vel = move_and_slide_with_snap(vel, Vector2.DOWN, Vector2.UP)
			StellaHurtbox.set_monitoring(false)
			yield(get_tree().create_timer(0.4), "timeout")
			$AnimationPlayer.stop(true)
			hide()
			go_to_checkpoint()

		PUSHFOLLOW:
			pushcheck()
			if Player.global_position.x < global_position.x - 10:
				vel.x = -WALK_MAX_SPEED
				direction.x = -1
			elif Player.global_position.x > global_position.x + 10:
				vel.x = WALK_MAX_SPEED
				direction.x = 1
			else:
				vel.x = 0
				direction.x = 0
			vel.x = direction.x * 630

			if direction.x == 1 and is_on_floor():
				animatedsprite.animation = "Pushing"
				animatedsprite.flip_h = false
				pushdetector.position = Vector2(63, 0)
			elif direction.x == -1 and is_on_floor():
				animatedsprite.animation = "Pushing"
				animatedsprite.flip_h = true
				pushdetector.position = Vector2(-59, 0)
			else:
				animatedsprite.animation = "Idle"

			vel.y += gravity * delta
			gravity = 1450.0
			vel = move_and_slide_with_snap(vel, Vector2.DOWN, Vector2.UP)

			if is_on_floor() and not was_on_floor:
				audioplayer.play()
			was_on_floor = is_on_floor()

			if is_on_floor() and Input.is_action_just_pressed("stellajump"):
				vel.y = -JUMP_SPEED
				if vel.y < 0:
					vel.y += 500

			if vel.y < 0 and not is_on_floor():
				if ouch == false:
					animatedsprite.animation = "Jumpgoesup"
				elif ouch == true:
					animatedsprite.animation = "Hurt"
				if direction.x == 1:
					animatedsprite.flip_h = false
				elif direction.x == -1:
					animatedsprite.flip_h = true
			elif vel.y > 0 and not is_on_floor():
				if ouch == false:
					animatedsprite.animation = "Jumpgoesdown"
				elif ouch == true:
					animatedsprite.animation = "Hurt"
				if direction.x == 1:
					animatedsprite.flip_h = false
				elif direction.x == -1:
					animatedsprite.flip_h = true

			if Input.is_action_pressed("stellacommand") and Input.is_action_just_pressed("left"):
				state = RUNAWAY
			if Input.is_action_pressed("stellacommand") and Input.is_action_just_pressed("down"):
				state = STANDSTILL
			if is_on_ladder():
				if Input.is_action_just_pressed("stellajump"):
					state = CLIMBIDLE

		PUSHRUN:
			pushcheck()
			if Player.global_position.x < global_position.x - 10:
				vel.x = WALK_MAX_SPEED
				direction.x = 1
			elif Player.global_position.x > global_position.x + 10:
				vel.x = -WALK_MAX_SPEED
				direction.x = -1
			else:
				vel.x = 0
				direction.x = 0
			vel.x = direction.x * 550

			vel.y += gravity * delta
			gravity = 1450.0
			vel = move_and_slide_with_snap(vel, Vector2.DOWN, Vector2.UP)

			if is_on_floor() and not was_on_floor:
				audioplayer.play()
			was_on_floor = is_on_floor()

			if direction.x == 1 and is_on_floor():
				animatedsprite.animation = "Pushing"
				animatedsprite.flip_h = false
				pushdetector.position = Vector2(63, 0)
			elif direction.x == -1 and is_on_floor():
				animatedsprite.animation = "Pushing"
				animatedsprite.flip_h = true
				pushdetector.position = Vector2(-59, 0)
			else:
				animatedsprite.animation = "Idle"

			if is_on_floor() and Input.is_action_just_pressed("stellajump"):
				vel.y = -JUMP_SPEED
				if vel.y < 0:
					vel.y += 500

			if vel.y < 0 and not is_on_floor():
				if ouch == false:
					animatedsprite.animation = "Jumpgoesup"
				elif ouch == true:
					animatedsprite.animation = "Hurt"
				if direction.x == 1:
					animatedsprite.flip_h = false
				elif direction.x == -1:
					animatedsprite.flip_h = true
			elif vel.y > 0 and not is_on_floor():
				if ouch == false:
					animatedsprite.animation = "Jumpgoesdown"
				elif ouch == true:
					animatedsprite.animation = "Hurt"
				if direction.x == 1:
					animatedsprite.flip_h = false
				elif direction.x == -1:
					animatedsprite.flip_h = true

			if Input.is_action_pressed("stellacommand") and Input.is_action_just_pressed("right"):
				state = FOLLOWME
			if Input.is_action_pressed("stellacommand") and Input.is_action_just_pressed("down"):
				state = STANDSTILL
			if is_on_ladder():
				if Input.is_action_just_pressed("stellajump"):
					state = CLIMBIDLE

func pushcheck():
	for index in get_slide_count():
		var collision = get_slide_collision(index)
		if collision.collider is PushableCopy:
			collision.collider.slide(-collision.normal * (speed / 2.5) )
		else:
			return false
	return true

func is_invul():
	immortal = true
	print("does it work")
	$FloaterActive.show()
	StellaHurtbox.set_monitoring(false)
	yield(get_tree().create_timer(30), "timeout")
	print("hope it did")
	StellaHurtbox.set_monitoring(true)
	$FloaterActive.hide()
	immortal = false

func is_on_ladder():
	if not ladderCheck.is_colliding(): return false
	var collider = ladderCheck.get_collider()
	if not collider is Ladder: return false
	return true

func go_to_checkpoint():
	if Signals.lives > 0:
		var thing = checkpointTween.interpolate_property(self, "position", position, last_checkpoint.global_position, 1, Tween.TRANS_EXPO, Tween.EASE_OUT)
		thing = checkpointTween.start()
		state = STANDSTILL
		health = 100
		$CollisionShape2D.disabled = true
		yield(get_tree().create_timer(0.4), "timeout")
		$CollisionShape2D.disabled = false
		StellaHurtbox.set_monitoring(true)
		show()
		animatedsprite.animation = "Jumpgoesdown"
		$AnimationPlayer.play("CompHurt")
	elif Signals.lives == 0:
		SceneManager.change_scene("level_transition_effect", "res://screens/GameOver.tscn")


func _on_PushDetector_area_entered(area):
	if area.name == "PushArea":
		if state == FOLLOWME:
			state = PUSHFOLLOW
		if state == RUNAWAY:
			state = PUSHRUN

func _on_PushDetector_area_exited(area):
	if area.name == "PushArea":
		if state == PUSHFOLLOW:
			state = FOLLOWME
		if state == PUSHRUN:
			state = RUNAWAY


func _on_StellaHurtbox_area_entered(Area2D):
	if Area2D.name == "EnemyHitbox":
		ouch = true
		$AnimationPlayer.play("CompHurt")
		health -= 10
		vel.y -= 500
		yield(get_tree().create_timer(0.5), "timeout")
		ouch = false
	if Area2D.name == "DeathHitbox":
		health = 0
