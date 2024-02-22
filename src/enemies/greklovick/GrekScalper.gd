extends KinematicBody2D

export var gravity: = 33600

var direction = Vector2.RIGHT
var velocity = Vector2.ZERO
var JUMP_SPEED = 1450
var WALK_MAX_SPEED = 70


onready var eyes = $Eyes
onready var animationplayer = $AnimationPlayer
onready var sprites = $Sprites
onready var jumptimer = $Timer
onready var Player = get_parent().get_node("Player/EatableHead")
#onready var Playerspeed = get_parent().get_node("Player")
#var icanjump = false

func _ready():
	jumptimer.start(2)
	animationplayer.play("RESET") 

enum {
	MOVING,
	JUMP,
	EATING,
	CHASE,
	DEAD
}

var state = MOVING

func _physics_process(delta):

	velocity = direction * 140
	velocity.y += gravity * delta
	move_and_slide(velocity, Vector2.UP)
	gravity = 33600

	match state:
		MOVING:
			sprites.play("moving")
			if see_to_attack() and is_on_floor():
				state = CHASE
			elif see_to_attack() and not is_on_floor():
				pass
			var found_wall = is_on_wall()
			if found_wall:
				direction *= -1
				scale.x = -scale.x
#			velocity = direction * 140
#			velocity.y += gravity * delta
#			move_and_slide(velocity, Vector2.UP)
#			gravity = 33600
		CHASE:


#			if jumptimer.time_left == 0:
#			do_a_jump()
#			jumptimer.start(2)
#			if jumptimer.time_left == 0:
#				icanjump = true
#				do_a_jump()

#			animationplayer.play("jumpy")

			if is_on_wall():
				do_a_jump()
#				velocity.y = -JUMP_SPEED
#				if velocity.y < 0:
#					velocity.y += 500

#			gravity = 33600
			if Player.global_position.x < global_position.x - 10:
				velocity.x = -WALK_MAX_SPEED
				direction.x = -1
				sprites.flip_h = false
#				if Player.global_position.y < global_position.y - 1:
#					state = JUMP
#				elif Player.global_position.y > global_position.y + 1:
#					pass
			elif Player.global_position.x > global_position.x + 10:
				velocity.x = WALK_MAX_SPEED
				direction.x = 1
				sprites.flip_h = true
#				if Player.global_position.y < global_position.y - 1:
#					state = do_a_jump()
#				elif Player.global_position.y > global_position.y + 1:
#					pass

#			else:
#				state = JUMP

#			if Player.global_position.y < global_position.y - 10:
#				state = JUMP
#				do_a_jump()
					
				
#			velocity = direction * 560
#			velocity.y += gravity * delta
#			move_and_slide(velocity, Vector2.UP)
#			gravity = 33600

#
#			if Player.global_position.y < global_position.y - 1:
#				state = JUMP
#			elif Player.global_position.y > global_position.y + 1:
#				pass
#			else:
#				print("nom")


		JUMP:
			do_a_jump()
			velocity.x = 0
			direction.x = 0
			velocity.y += gravity * delta
			move_and_slide(velocity, Vector2.UP)
#			velocity = move_and_slide_with_snap(velocity, Vector2.DOWN, Vector2.UP)
			gravity = 3000

			sprites.play("jump")

			var found_wall = is_on_wall()
			if found_wall:
				do_a_jump()


		EATING:
			sprites.play("eating")
			global_position = Player.global_position

		DEAD:
			animationplayer.play("Dying") 
			sprites.play("dead")
			velocity.x = 0
			direction.x = 0
			velocity.y += gravity * delta
			move_and_slide(velocity, Vector2.UP)
			gravity = 33600


func die():
	queue_free()

func do_a_jump():
#	if icanjump == true:
#	if jumptimer.time_left == 0:
	velocity.y = -JUMP_SPEED
	if velocity.y < 0:
		velocity.y += JUMP_SPEED
#		icanjump = false
#		state = CHASE
#			jumptimer.start(2)



func see_to_attack():
	if not eyes.is_colliding(): return false
	var collider = eyes.get_collider()
	if not collider.is_in_group("player"): return false
	return true



func _on_HeadEater_body_entered(body):
	if state == CHASE and body.name == "Player":
		state = EATING


func _on_AltHurtBox_area_entered(area):
	if state == EATING and area.name == "PlayerMelee":
		state = DEAD


func _on_HurtBoxScalper_area_entered(area):
	if area.name == "PlayerMelee":
		state = DEAD
	if area.name == "EnemyCrusher":
		state = DEAD
