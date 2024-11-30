extends KinematicBody2D

#NOTE: I WISH THERE WAS A WAT TO LIMIT THE SCALE

export var number = 25
var currentFrame: int = 0

onready var sprite = $AnimatedSprite
onready var start_position = global_position

var speed = 900
var velocity = Vector2()

var scale_speed = .5


func _ready():
	pass 

func _process(delta):
	if Input.is_action_just_pressed("cameratest"):
		currentFrame += 1
		if currentFrame > number:
			currentFrame = 0
		sprite.frame = currentFrame

#func _physics_process(delta):
#	print(scale)
	velocity = Vector2()
	if Input.get_action_strength("right"):
		velocity.x -= speed
	elif Input.get_action_strength("left"):
		velocity.x += speed
	elif Input.get_action_strength("jumpup"):
		velocity.y += speed
	elif Input.get_action_strength("down"):
		velocity.y -= speed
	else:
		velocity.x = 0
		velocity.y = 0
	if Input.is_action_just_pressed("pressespace"):
		global_position = start_position
		scale = Vector2(1, 1)

	if Input.is_action_pressed("interactcomp"):
		scale -= scale_speed * delta * Vector2(1, 1)
	elif Input.is_action_pressed("stellajump"):
		scale += scale_speed * delta * Vector2(1, 1)
#		print(scale)

	if scale > Vector2(6, 6):
		scale = Vector2(6, 6)

	move_and_slide(velocity)
#	velocity = move_and_slide_with_snap(velocity, Vector2.DOWN, Vector2.UP)
