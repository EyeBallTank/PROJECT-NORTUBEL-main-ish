extends StaticBody2D

onready var sprite = $NumberBasedDoor
export var spritename = "default"
export var idealnumber = 5
var currentnumber = 0

onready var animationplayer = $AnimationPlayer

func _ready():
	animationplayer.play("RESET")
	Signals.connect("collectible_picked", self, "_number_goes_up")
	sprite.animation = spritename

func _number_goes_up():
	currentnumber += 1

func _physics_process(delta):
	if currentnumber == idealnumber:
		animationplayer.play("disappear")

func die():
	queue_free()
