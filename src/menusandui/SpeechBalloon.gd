extends AnimatedSprite

func _ready():
	hide()

func _physics_process(_delta):
	if Input.is_action_pressed("kickball") and Input.is_action_just_pressed("down"):
		show()
		animation = "BalloonStop"
#		yield(get_tree().create_timer(0.5), "timeout")
#		hide()
	if Input.is_action_pressed("kickball") and Input.is_action_just_pressed("left"):
		show()
		animation = "BalloonRun"
#		yield(get_tree().create_timer(0.5), "timeout")
#		hide()
	if Input.is_action_pressed("kickball") and Input.is_action_just_pressed("right"):
		show()
		animation = "BalloonFollow"
#		yield(get_tree().create_timer(0.5), "timeout")
#		hide()
	if Input.is_action_pressed("simplefollow"):
		show()
		animation = "BalloonFollow"
	if Input.is_action_pressed("simplerunaway"):
		show()
		animation = "BalloonRun"
	if Input.is_action_pressed("simplestandstill"):
		show()
		animation = "BalloonStop"


	if Input.is_action_pressed("stellacommand") and Input.is_action_just_pressed("down"):
		show()
		animation = "BalloonStop"
#		yield(get_tree().create_timer(0.5), "timeout")
#		hide()
	if Input.is_action_pressed("stellacommand") and Input.is_action_just_pressed("left"):
		show()
		animation = "BalloonRun"
#		yield(get_tree().create_timer(0.5), "timeout")
#		hide()
	if Input.is_action_pressed("stellacommand") and Input.is_action_just_pressed("right"):
		show()
		animation = "BalloonFollow"
#		yield(get_tree().create_timer(0.5), "timeout")
#		hide()

#maybe not the best method
	if Input.is_action_just_released("down"):
		hide()
	if Input.is_action_just_released("right"):
		hide()
	if Input.is_action_just_released("left"):
		hide()
	if Input.is_action_just_released("standstill"):
		hide()
	if Input.is_action_just_released("simplefollow"):
		hide()
	if Input.is_action_just_released("simplestandstill"):
		hide()
	if Input.is_action_just_released("simplerunaway"):
		hide()
