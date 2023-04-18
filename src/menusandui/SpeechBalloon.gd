extends AnimatedSprite

func _ready():
	hide()

func _physics_process(_delta):
	if Input.is_action_pressed("kickball") and Input.is_action_just_pressed("jumpup"):
		show()
		animation = "BalloonStop"
		yield(get_tree().create_timer(0.5), "timeout")
		hide()
	if Input.is_action_pressed("kickball") and Input.is_action_just_pressed("left"):
		show()
		animation = "BalloonRun"
		yield(get_tree().create_timer(0.5), "timeout")
		hide()
	if Input.is_action_pressed("kickball") and Input.is_action_just_pressed("right"):
		show()
		animation = "BalloonFollow"
		yield(get_tree().create_timer(0.5), "timeout")
		hide()
