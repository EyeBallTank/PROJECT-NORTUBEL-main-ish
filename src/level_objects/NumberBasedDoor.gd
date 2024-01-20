extends StaticBody2D


export var idealnumber = 5
var currentnumber = 0

func _ready():
	Signals.connect("collectible_picked", self, "_number_goes_up")

func _number_goes_up():
	currentnumber += 1

func _physics_process(delta):
	if currentnumber == idealnumber:
		queue_free()
