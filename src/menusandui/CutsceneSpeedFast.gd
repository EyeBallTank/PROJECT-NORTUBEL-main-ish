extends AnimatedSprite

func _ready():
	animation = "off"

func _physics_process(_delta):
	if Input.is_action_pressed("interactcomp"):
		animation = "on"
	if Input.is_action_just_released("interactcomp"):
		animation = "off"
