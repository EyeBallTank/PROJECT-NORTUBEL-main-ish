extends KinematicBody2D

export var gravity: = 29600
var direction = Vector2.RIGHT
var velocity = Vector2.ZERO
onready var sprite = $AnimatedSprite

func _physics_process(delta):
	velocity.y += gravity * delta
	move_and_slide(velocity, Vector2.UP)

func _ready():
	sprite.animation = "normal"


func _on_Enter_body_entered(body):
	if body.name == "Player":
		sprite.animation = "open"


func _on_Drive_body_entered(body):
	if body.name == "Player":
		velocity = direction * 320
